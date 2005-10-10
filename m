Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbVJJTVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbVJJTVl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 15:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbVJJTVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 15:21:41 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2527 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751108AbVJJTVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 15:21:41 -0400
Date: Mon, 10 Oct 2005 21:21:30 +0200
From: Pavel Machek <pavel@suse.cz>
To: Etienne Lorrain <etienne.lorrain@masroudeau.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Gujin linux.kgz boot format
Message-ID: <20051010192130.GB2204@elf.ucw.cz>
References: <2031.192.168.201.6.1128591983.squirrel@pc300> <20051007144631.GA1294@elf.ucw.cz> <2520.192.168.201.6.1128943428.squirrel@pc300> <20051010115641.GA2983@elf.ucw.cz> <3125.192.168.201.6.1128949772.squirrel@pc300> <20051010131925.GA19256@atrey.karlin.mff.cuni.cz> <3768.192.168.201.6.1128954688.squirrel@pc300>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3768.192.168.201.6.1128954688.squirrel@pc300>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> > may be good goal...
> >>
> >>   At least that is a way which does not involve modifying assembler
> >>  files. Slowly everybody switches to the C version which continue
> >>  to evolve (i.e. removing old BIOS calls), then the tree under
> >>  arch/i386/boot is removed and we can begin to rearrange the mapping
> >>  of "struct linux_param".
> >
> > Will your C version work with lilo and grub?
> 
>   Tricky question. In short no, it cannot.

I do not see a point, then. We have bad assembly bootup code. Adding
good C bootup code, that is incompatible with lilo/grub does nothing
to clean the mess up.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
