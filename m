Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264463AbUBAA2w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 19:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264539AbUBAA2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 19:28:52 -0500
Received: from post.tau.ac.il ([132.66.16.11]:58842 "EHLO post.tau.ac.il")
	by vger.kernel.org with ESMTP id S264463AbUBAA2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 19:28:51 -0500
Date: Sun, 1 Feb 2004 02:26:41 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: linux-kernel@vger.kernel.org
Cc: M?ns Rullg?rd <mru@kth.se>
Subject: Re: Software Suspend 2.0
Message-ID: <20040201002641.GB31914@luna.mooo.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	M?ns Rullg?rd <mru@kth.se>
References: <1075534088.18161.61.camel@laptop-linux> <20040131073848.GE7245@digitasaru.net> <1075537924.17730.88.camel@laptop-linux> <401B6F7A.5030103@gmx.de> <1075540107.17727.90.camel@laptop-linux> <401B7312.3060207@gmx.de> <1075542685.25454.124.camel@laptop-linux> <401B86EB.50604@gmx.de> <yw1xznc4tfle.fsf@kth.se> <20040131231134.GA6084@digitasaru.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040131231134.GA6084@digitasaru.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.23.0.3; VDF: 6.23.0.53; host: localhost)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 31, 2004 at 05:11:37PM -0600, Joseph Pingenot wrote:
> >From M?ns Rullg?rd on Saturday, 31 January, 2004:
> >"Prakash K. Cheemplavam" <PrakashKC@gmx.de> writes:
> >>> My error. My patch script has put kernel/power/swsusp2.c in the version
> >> No problem. I already tested it. After throwing out usb modules, it
> >> did suspend, though taking quite long at the kernel and processing
> >> (something like that) message. But upon restart, it didn't resume,
> >> ie. it didn't find its image, just normal swap space.
> >Try disabling write cache on the disk with hdparm -W0 /dev/hde.
> 
> When should this be done?
> 
> I have 2.6.1 + the 2.6.1-specific patches + core patches.  It suspends
>   without difficulty, but on boot, it says it couldn't read a part
>   of the resume data (a "chunk", iirc).  The status bar doesn't make
>   much progress.
> 
> I tried hdparm -W 0 right before the call to hibernate (in a script).
>   But I still have the problem.
> 
> When should hdparm be called?
> 

Is X running with dri support? If so as a start try stopping X and see
if that solves your problem (there is still a problem with most of the
agp and drm drivers suspend support)

> Thanks!
> 
> -Joseph
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
