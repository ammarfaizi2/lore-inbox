Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313333AbSC2BVD>; Thu, 28 Mar 2002 20:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313331AbSC2BUy>; Thu, 28 Mar 2002 20:20:54 -0500
Received: from 136.139.hh1.ip.foni.net ([212.7.139.136]:10500 "HELO
	debian.heim.lan") by vger.kernel.org with SMTP id <S313332AbSC2BUt>;
	Thu, 28 Mar 2002 20:20:49 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Christian Schoenebeck <christian.schoenebeck@epost.de>
To: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Subject: Re: power off
Date: Fri, 29 Mar 2002 02:20:06 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.SOL.3.96.1020328224816.4244A-100000@draco.cus.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020329005604.D66CE47B4@debian.heim.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please cc me)

Es geschah am Donnerstag, 28. März 2002 23:52 als Anton Altaparmakov schrieb:
> You mell well find that you just need to upgrade your userspace utilities
> to make it work. For me, using the exact same kernel!!! but a different
> distro makes the difference between the computer just sitting there when I
> shutdown -h now or actually powering off...

I'm using latest Debian Woody - up to date packages, so I don't think that 
should be the problem.

> Having said all that some versions of 2.4 kernels have broken shutdown so
> it would help if you said which kernel version you are using...

First I used 2.2.19pre17 and everything was fine, now unfortunately I had to 
move to 2.4.x and tried 2.4.17 and now 2.4.7 (both Debian customized). Of 
course I enabled apm ("apm=on" kernel parameter and also "Enable PM at boot 
time"). As this didn't work, I also tried "User real mode APM...", "Allow 
Interrupts..." and I tried ACPI instead. All didn't work!

So is there anything else I can do?

> On Thu, 28 Mar 2002, Christian Schoenebeck wrote:
> > (please cc me)
> >
> > Hi everybody!
> >
> > I've got a problem with a machine (using an Asus SP98AGP-X mainboard)
> > that doesn't want to power off since moving from 2.2.x to 2.4.x kernel.
> > As I haven't found any other solution, can I simply replace the new apm.c
> > by the old one from 2.2.x or just a part of the unit or would that be
> > fatal?
> >
> > PLEASE HELP ME WITH THIS!
> >
> > Thanks in advance,
> >
> > Christian Schoenebeck
