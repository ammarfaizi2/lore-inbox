Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265089AbUFRKM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265089AbUFRKM4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 06:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265092AbUFRKM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 06:12:56 -0400
Received: from smtp-out3.xs4all.nl ([194.109.24.13]:34571 "EHLO
	smtp-out3.xs4all.nl") by vger.kernel.org with ESMTP id S265089AbUFRKMy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 06:12:54 -0400
Date: Fri, 18 Jun 2004 12:12:48 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.local
To: 4Front Technologies <dev@opensound.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Stop the Linux kernel madness
In-Reply-To: <40D2464D.2060202@opensound.com>
Message-ID: <Pine.LNX.4.58.0406181205500.13079@scrub.local>
References: <40D232AD.4020708@opensound.com> <20040618004450.GT12308@parcelfarce.linux.theplanet.co.uk>
 <40D23EBD.50600@opensound.com> <Pine.LNX.4.58.0406180313350.10292@scrub.local>
 <40D2464D.2060202@opensound.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 17 Jun 2004, 4Front Technologies wrote:

> The problem with SuSE is that /lib/modules/2.6.5-7.75/build is all screwy. Either
> you do the right thing like Fedora or Redhat and ship the proper KBUILD environment
> or link it to /usr/src/linux and atleast have the kernel headers intact.

To quote from your previous mail:

> make -C /lib/modules/`uname -r`/build scripts scripts_basic include/linux/version.h
> make[1]: Entering directory `/usr/src/linux-2.6.5-7.75-obj/i386/bigsmp'
> make[1]: Nothing to be done for `scripts'.
> make[1]: *** No rule to make target `scripts_basic'.  Stop.
> make[1]: Leaving directory `/usr/src/linux-2.6.5-7.75-obj/i386/bigsmp'
> make: *** [ossbuild] Error 2

That doesn't really like documented interfaces to me. The SuSE kernel 
build system may be unconventional, but so far you failed miserably to 
prove that they did anything wrong. You should actually be thankful to 
them, that you can fix your broken build scripts to use _documented_ 
interfaces.

bye, Roman
