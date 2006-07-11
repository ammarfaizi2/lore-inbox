Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbWGKSPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWGKSPz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 14:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWGKSPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 14:15:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:42191 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751176AbWGKSPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 14:15:54 -0400
Date: Tue, 11 Jul 2006 20:15:52 +0200
From: Olaf Hering <olh@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jeff Garzik <jeff@garzik.org>, Michael Tokarev <mjt@tls.msk.ru>,
       Roman Zippel <zippel@linux-m68k.org>, torvalds@osdl.org,
       klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [klibc] klibc and what's the next step?
Message-ID: <20060711181552.GD16869@suse.de>
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.0606271316220.17704@scrub.home> <20060711044834.GA11694@suse.de> <44B37D9D.8000505@tls.msk.ru> <20060711112746.GA14059@suse.de> <44B3D0A0.7030409@zytor.com> <20060711164040.GA16327@suse.de> <44B3DA77.50103@garzik.org> <20060711171624.GA16554@suse.de> <44B3E7D5.8070100@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <44B3E7D5.8070100@zytor.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Jul 11, H. Peter Anvin wrote:

> Olaf Hering wrote:
> >
> >There is always some sort of prereq when new features get added.
> >Documentation/Changes has a long list. Some setup need more updates,
> >some need fewer updates. No idea what your experience is.
> >Old klibc was trivial to build (modulo that kernel header mess), and I
> >expect that kinit handles old kernels.
> >
> 
> One more thing on this subject... "modulo that kernel header mess" is 
> just as much a reflection of the fact that the Linux ABI really isn't 
> particularly stable.  glibc contains a huge amount of code to deal with 
> different kernel versions.  klibc will not be doing this; in general old 
> klibcs should continue to work (but may not compile against a newer 
> kernel), but a newer klibc may not work on an older kernel.

"It would be nice if ..." someone can build a list of things that
changed over time. Say from 2.0.0 to 2.6.18. Just struct layouts and defines.

I havent tried it, but one would hope that the /bin/ls from SuSE 5.3 still
works today.  Guess its time for me to actually try that the next days.
