Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbVKJQOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbVKJQOt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 11:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbVKJQOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 11:14:49 -0500
Received: from darwin.snarc.org ([81.56.210.228]:15050 "EHLO darwin.snarc.org")
	by vger.kernel.org with ESMTP id S1750873AbVKJQOs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 11:14:48 -0500
Date: Thu, 10 Nov 2005 17:14:46 +0100
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 12/21] i386 Deprecate descriptor asm
Message-ID: <20051110161446.GA13204@snarc.org>
References: <200511080431.jA84Vdg5009909@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511080431.jA84Vdg5009909@zach-dev.vmware.com>
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.9i
From: tab@snarc.org (Vincent Hanquez)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 08:31:39PM -0800, Zachary Amsden wrote:
> +struct desc_internal_struct {
> +	unsigned short	limit0;
> +	unsigned short	base0;
> +	unsigned char	base1;
> +	unsigned char	type;
> +	unsigned int	limit1 : 4;
> +	unsigned int	flags : 4;
> +	unsigned char	base2;
> +} __attribute__((packed));

just a minor nit,

wouldn't that be better to use u8 and u16 types here ? 

Cheers,
-- 
Vincent Hanquez
