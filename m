Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261561AbSI2FgI>; Sun, 29 Sep 2002 01:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262394AbSI2FgI>; Sun, 29 Sep 2002 01:36:08 -0400
Received: from paloma14.e0k.nbg-hannover.de ([62.181.130.14]:56470 "HELO
	paloma14.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S261561AbSI2FgH> convert rfc822-to-8bit; Sun, 29 Sep 2002 01:36:07 -0400
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>
Subject: Re: System very unstable
Date: Sun, 29 Sep 2002 07:41:40 +0200
User-Agent: KMail/1.4.3
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209290741.40679.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-29 at 00:42, Kristofer T. Karas wrote:
> On Sat, 2002-09-28 at 07:34, David S. Miller wrote:
> > This is old news, they opensource the drivers at a later date,
> > this is how it's always worked with ATI.
>
> Note that ATI now has a binary driver available that supports the 8500,
> written by their German development group.  Available via their standard
> "find a driver" page, using Linux as OS.  See, for example,
> http://mirror.ati.com/support/products/pc/radeon8500/linux/radeon8500 \
> linuxdrivers.html?cboOS=LinuxXFree86&cboProducts=RADEON+8500 \
> LE&cmdNext=GO%21
>
> The scripts that build a kernel module and link it against their library
> work pretty well and are, to their credit, not impossibly tied to one
> distro over another.  :-)  I run Slackware.
>
>        ktk@madmax:~$ glxgears 
>        10474 frames in 5.0 seconds = 2094.800 FPS
>        10797 frames in 5.0 seconds = 2159.400 FPS

This is slower than the current DRI can do ;-)

dual Athlon MP 1900+ (but all XFree and Mesa stuff is single threaded 
currently):

Mesa/demos> ./gears
r200CreateScreen
6465 frames in  5.000 seconds = 1293.000 FPS
11955 frames in  5.000 seconds = 2391.000 FPS
11954 frames in  5.000 seconds = 2390.800 FPS
11955 frames in  5.000 seconds = 2391.000 FPS
11954 frames in  5.000 seconds = 2390.800 FPS

I wonder why nobody point to the place were "the real development" is?

dri.sourceforge.net
or the new test site (under construktion)
http://lfm.sourceforge.net/dritest/

Xv is supported with the current trunk, too.
If you need the video capabilities take a look at the GATOS page.
http://gatos.sourceforge.net/

Cheers,
	Dieter

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel at hamburg.de (replace at with @)
