Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129524AbRCUCCS>; Tue, 20 Mar 2001 21:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129618AbRCUCCI>; Tue, 20 Mar 2001 21:02:08 -0500
Received: from paloma14.e0k.nbg-hannover.de ([62.159.219.14]:26111 "HELO
	paloma14.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S129524AbRCUCB7>; Tue, 20 Mar 2001 21:01:59 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Dieter Nützel <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: "Linus Torvalds" <torvalds@transmeta.com>
Subject: Re: Linux 2.4.2 fails to merge mmap areas, 700% slowdown.
Date: Wed, 21 Mar 2001 03:02:13 +0100
X-Mailer: KMail [version 1.2]
Cc: "Linux Kernel List" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <01032103021300.21085@SunWave1>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:
> 
> Cool. Somebody actually found a real case.
> 
> I'll fix the mmap case asap. Its' not hard, I just waited to see if it
> ever actually triggers. Something like g++ certainly counts as major.

I do daily builds of the VTK CVS tree (The Visualization Toolkit, 
www.kitware.com/vtk.html, a huge 3D app).

~33 MB C++ source

It took ~1 hour on my K7 550, 256 MB, IBM DTL-307030, glibc-2.2 and 
gcc-2.95.2 ( 19991024 (release)) under most of the 2.4-test kernels (all with 
ReiserFS) for a whole rebuild.
Now it take nearly 1 and a half hour with 2.4.2-ac20.
BTW My mouse (PS2) is very sluggished during C++ compilations, now.

I am open for all of your patches. Or should I better say most :-)))

Cheers,
	Dieter
-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
Cognitive Systems Group
Vogt-Kölln-Straße 30
D-22527 Hamburg, Germany

email: nuetzel@kogs.informatik.uni-hamburg.de
@home: Dieter.Nuetzel@hamburg.de
