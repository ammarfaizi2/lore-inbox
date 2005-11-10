Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbVKJOSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbVKJOSr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 09:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbVKJOSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 09:18:47 -0500
Received: from ns.suse.de ([195.135.220.2]:8912 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750840AbVKJOSq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 09:18:46 -0500
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [PATCH 12/21] i386 Deprecate descriptor asm
Date: Thu, 10 Nov 2005 15:18:25 +0100
User-Agent: KMail/1.8
Cc: Zachary Amsden <zach@vmware.com>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
References: <200511080431.jA84Vdg5009909@zach-dev.vmware.com>
In-Reply-To: <200511080431.jA84Vdg5009909@zach-dev.vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511101518.25744.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 November 2005 05:31, Zachary Amsden wrote:
> Ancient inline assembler that manipulates descriptor tables is unreadable
> and has no type checking.  Doing this in C actually generates better code,
> saves code space, and improves readability.

Great idea. This was one of the first things I changed in the x86-64 port.
-Andi

