Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315735AbSECW2U>; Fri, 3 May 2002 18:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315736AbSECW2U>; Fri, 3 May 2002 18:28:20 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:60386 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315735AbSECW2T>; Fri, 3 May 2002 18:28:19 -0400
To: Guest section DW <dwguest@win.tue.nl>
cc: Jeff Dike <jdike@karaya.com>, linux-kernel@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: UML is now self-hosting! 
In-Reply-To: Your message of Fri, 03 May 2002 23:51:02 +0200.
             <20020503215102.GA24653@win.tue.nl> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6695.1020464883.1@us.ibm.com>
Date: Fri, 03 May 2002 15:28:03 -0700
Message-Id: <E173lX2-0001k3-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020503215102.GA24653@win.tue.nl>, > : Guest section DW writes:
> Congratulations!
> 
> [Reminds me of the good old times 30 years ago -
> had a tower of three virtual machines on top of a
> real PDP 8/I. Now that you can run UML under UML,
> can you run UML under UML under UML?]

Fun stuff!  With PTX we were doing something very similar near
the end of our days with PTX:

PTX could run Linux Binaries
PTX could run a System 390 emulator (Flex/ES ?)
PTX could *almost* run VMWare (might be able to run Win4Lin or Boochs...)
PTX could sever as a Citrix (Windows NT) server

Picture Windows running in VMWare, talking to an OS/390 emulator
on the same hardware.  You might have been able to run Linux on
390, as well as VM/SP or whatever...

Add on all the other Linux emulators and you had quite a few applications
you could run on a single platform, all able to talk to each other.  ;-)

Customers wanted to run legacy OS/390 apps that they had lost the
binaries for, with a fast, modern database (Oracle or DB2) running
at native speed, with either Linux or Windows applications.  Add
UML and you can do development and client support like System 390
can do with Linux and you have an interesting (if a bit perverted ;-)
world.

Sick and twisted...

gerrit
