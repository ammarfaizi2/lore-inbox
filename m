Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263730AbTDTXAJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 19:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263732AbTDTXAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 19:00:09 -0400
Received: from p006.as-l031.contactel.cz ([212.65.234.198]:29568 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id S263730AbTDTXAI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 19:00:08 -0400
Date: Mon, 21 Apr 2003 01:06:58 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Pierfrancesco Caci <pf@tippete.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.68] matroxfb still doesn't compile
Message-ID: <20030420230658.GA2583@ppc.vc.cvut.cz>
References: <87r87x2f6z.fsf@home.tippete.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r87x2f6z.fsf@home.tippete.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 20, 2003 at 08:31:48PM +0200, Pierfrancesco Caci wrote:
> 
> This error is still present:
> here it is:
> 
> /usr/bin/make -f scripts/Makefile.build obj=drivers/video/matrox
>   gcc -Wp,-MD,drivers/video/matrox/.matroxfb_base.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=matroxfb_base -DKBUILD_MODNAME=matroxfb_base -c -o drivers/video/matrox/.tmp_matroxfb_base.o drivers/video/matrox/matroxfb_base.c
> In file included from drivers/video/matrox/matroxfb_base.c:105:

Patch for 2.5.68 is at usual place
(ftp://platan.vc.cvut.cz/pub/linux/matrox-latest). I think that there 
is regression in handling cursor on other heads than primary one, 
but I can confirm it only on tuesday, as my current system has only
one video output.

I have no plans about submitting fixes to Linus, so please next time
before reporting problem try latest updates from my ftp. It is well
known that matroxfb does not build, and it will stay that way until
I'll get satisfied with quality of driver & interaction with fbdev
& fbcon level. I think that it is better to have no driver than
driver without cursor...

					Best regards,
						Petr Vandrovec



