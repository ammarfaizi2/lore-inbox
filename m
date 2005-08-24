Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbVHXSBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbVHXSBa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 14:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbVHXSBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 14:01:30 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:18446 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751339AbVHXSBa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 14:01:30 -0400
Date: Wed, 24 Aug 2005 14:01:12 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: =?iso-8859-1?Q?M=E1rcio?= Oliveira <moliveira@latinsourcetech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with kernel image in a Prep Boot on PowerPC
Message-ID: <20050824180110.GE1100@tuxdriver.com>
Mail-Followup-To: =?iso-8859-1?Q?M=E1rcio?= Oliveira <moliveira@latinsourcetech.com>,
	linux-kernel@vger.kernel.org
References: <430C8CB5.1050501@latinsourcetech.com> <20050824163100.GD1100@tuxdriver.com> <430CB3EC.2000502@latinsourcetech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <430CB3EC.2000502@latinsourcetech.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 02:52:44PM -0300, Márcio Oliveira wrote:

> The command rdev can change the default root partition on x86 linux 
> systems with pre-built kernels.
 
Of course...I meant I don't know of anything like that for PPC.

> About the CONFIG_CMDLINE in the kernel configuration, I found it in lots 
> of files in the kernel source tree and I'd like to know which file I 
> need to change this value (/usr/src/linux/arch/ppc64/defconfig ?).
 
Probably just in your .config file:

	cp arch/ppc64/defconfig .config
	vi .config # Change CONFIG_CMDLINE here
	make oldconfig

> According to this doc: 
> http://www-128.ibm.com/developerworks/eserver/library/es-SW_RAID_LINUX.html, 
> ppc64 can use zImage-style boot wrapper, so I'm trying it.

Cool...I think you will like having that as an option.

John
-- 
John W. Linville
linville@tuxdriver.com
