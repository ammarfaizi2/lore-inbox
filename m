Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261527AbSIZVLC>; Thu, 26 Sep 2002 17:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261526AbSIZVLB>; Thu, 26 Sep 2002 17:11:01 -0400
Received: from ext-nj2gw-2.online-age.net ([216.35.73.164]:41923 "EHLO
	ext-nj2gw-2.online-age.net") by vger.kernel.org with ESMTP
	id <S261525AbSIZVLA>; Thu, 26 Sep 2002 17:11:00 -0400
Message-ID: <A9713061F01AD411B0F700D0B746CA6802FC14D7@vacho6misge.cho.ge.com>
From: "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>
To: "'Arjan van de Ven'" <arjanv@redhat.com>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: Distributing drivers independent of the kernel source tree
Date: Thu, 26 Sep 2002 17:16:03 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


That's true for installing modules, but I'm wondering about getting a
standalone module compiled. I.e., what is a reliable method for locating the
include files for the kernel?

I can find references on the web where this has been discussed in the past,
but I have not found a resolution.


> -----Original Message-----
> From: Arjan van de Ven [mailto:arjanv@redhat.com]
> Sent: Thursday, September 26, 2002 4:09 PM
> To: Heater, Daniel (IndSys, ""GEFanuc, VMIC)
> Cc: 'Linux Kernel Mailing List'
> Subject: Re: Distributing drivers independent of the kernel 
> source tree
> 
> 
> On Thu, 2002-09-26 at 22:55, Heater, Daniel (IndSys, GEFanuc, VMIC) 
> > 2. Assuming the kernel source is in /usr/src/linux is not 
> always valid.
> > 
> > 3. I currently use /usr/src/linux-`uname -r` to locate the 
> kernel source
> > which is just as broken as method #2.
> 
> you have to use
> 
> /lib/modules/`uname -r`/build
> (yes it's a symlink usually, but that doesn't matter)
> 
> 
> that's what Linus decreed and that's what all distributions honor, and
> that's that make install does for manual builds.
> 
> Greetings,
>    Arjan van de Ven
> 
