Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbVL3CMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbVL3CMU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 21:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbVL3CMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 21:12:20 -0500
Received: from wscnet.wsc.cz ([212.80.64.118]:46720 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1750771AbVL3CMS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 21:12:18 -0500
Message-ID: <43B49715.9010809@liberouter.org>
Date: Fri, 30 Dec 2005 03:10:29 +0100
From: Jiri Slaby <slaby@liberouter.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Linus Torvalds <torvalds@osdl.org>, Ryan Anderson <ryan@michonline.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: userspace breakage
References: <20051228214845.GA7859@elte.hu> <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu> <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229202852.GE12056@redhat.com> <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org> <20051229224103.GF12056@redhat.com> <43B48176.3080509@michonline.com> <20051230004608.GA12822@redhat.com> <Pine.LNX.4.64.0512291702140.3298@g5.osdl.org> <20051230012145.GD12822@redhat.com>
In-Reply-To: <20051230012145.GD12822@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
>
I don't know what's wrong (or different), but
$ uname -a
Linux bellona 2.6.15-rc7 #1 SMP PREEMPT Fri Dec 30 02:56:57 CET 2005
i686 i686 i386 GNU/Linux
$ cat /etc/fedora-release
Fedora Core release 4 (Stentz)
$ rpm -q udev hal
udev-077-1
hal-0.5.5.1-1
from SRPMS from
http://download.fedora.redhat.com/pub/fedora/linux/core/development/SRPMS/
[maybe this is the difference? btw. despite, rc5-mm3 sound is defunct --
sound class is under device's class, but it's mm tree]
and at last the point of this e-mail:

$ ls /dev/input/
event0  event1  mice  mouse0  wacom

(udev created them, I'm sure)

all the best,

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E

