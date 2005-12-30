Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbVL3Ca2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbVL3Ca2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 21:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbVL3Ca2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 21:30:28 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:54216 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1750767AbVL3Ca2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 21:30:28 -0500
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Fri, 30 Dec 2005 03:29:52 +0100
Subject: Re: userspace breakage
To: Dave Jones <davej@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Ryan Anderson <ryan@michonline.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Message-Id: <20051230022950.A858E1D3610@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[sorry for suplicity (if any)]

Dave Jones napsal(a):
>With 2.6.14 on my testbox, I get this..
>
>$ ls /dev/input/
>event0  event1  mice  mouse0
>
>With 2.6.15rc
>
>$ ls /dev/input/
>mice
>
I don't know what's wrong, but
$ uname -a
Linux bellona 2.6.15-rc7 #1 SMP PREEMPT Fri Dec 30 02:56:57 CET 2005 i686 i686 i386 GNU/Linux
$ cat /etc/fedora-release
Fedora Core release 4 (Stentz)
$ rpm -q udev hal
udev-077-1
hal-0.5.5.1-1
from SRPMS from http://download.fedora.redhat.com/pub/fedora/linux/core/development/SRPMS/
[maybe this is the difference? btw. despite, rc5-mm3 sound is defunct -- sound class is under device's class]
and at last the point of this e-mail:

$ ls /dev/input/
event0  event1  mice  mouse0  wacom

(udev created them, I'm sure)

all the best,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
