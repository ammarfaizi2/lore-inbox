Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262221AbUKDNpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbUKDNpq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 08:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbUKDNpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 08:45:46 -0500
Received: from linux.us.dell.com ([143.166.224.162]:58779 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S262221AbUKDNpl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 08:45:41 -0500
Date: Thu, 4 Nov 2004 07:45:34 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: boot option for CONFIG_EDD_SKIP_MBR?
Message-ID: <20041104134534.GA5360@lists.us.dell.com>
References: <418A303E.1050709@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418A303E.1050709@gmx.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 02:35:58PM +0100, Carl-Daniel Hailfinger wrote:
> [please CC: me on replies]
> having had problems (inifinte hang on boot) with some Fujitsu
> Siemens Scenic computers when EDD was enabled, I asked myself
> if it would be possible to add a boot option edd=nombr and
> possibly also another boot option edd=off to the EDD code in
> the kernel. These would correspond to CONFIG_EDD_SKIP_MBR
> and CONFIG_EDD, respectively.
>
> Yes, option parsing before entering protected mode is ugly,
> but the vga setup code does it, too.
> 
> What do you think?

I'd love it.  I hadn't done it as I thought it would be ugly, and so
far I could blame buggy BIOSes for the delay.  If you want to work up
a patch, I'll gladly review and apply something that does such.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
