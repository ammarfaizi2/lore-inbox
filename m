Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318772AbSG0PSu>; Sat, 27 Jul 2002 11:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318773AbSG0PSu>; Sat, 27 Jul 2002 11:18:50 -0400
Received: from wn1.sci.kun.nl ([131.174.8.1]:34710 "EHLO wn1.sci.kun.nl")
	by vger.kernel.org with ESMTP id <S318772AbSG0PSs>;
	Sat, 27 Jul 2002 11:18:48 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Danny Tholen <danny@mailmij.org>
Reply-To: danny@mailmij.org
To: kernellist <linux-kernel@vger.kernel.org>
Subject: no visible screen with console driver.
Date: Sat, 27 Jul 2002 17:20:34 +0200
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200207271720.41657.danny@mailmij.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


I think there is a small problem in the linux console driver, although it could also just be my hardware.
Anyway, I have a problem on 2 machines with an A7V-266E motherboard, an IIyama HM704 monitor
and 2 different nvidia cards.
The problem is rather simple: when the console driver starts, the screen turns black. X starts normally
and is visible. And than when I go back to a virtual console it suddenly appears correctly. Apperently X
resets the console better than the kernel:)
The vesa driver also doesn't give a visible screen. But either the rivafb or vga16fb switch the screen back
to visible after a few seconds. 
Horizontal and vertical refresh rates as indicated by the monitor info are similar; when I have a visible
screen or not. The problem also is in the 2.2 kernels that I tested.

Anyone any idea where to look for the problem, or what is the difference between switching from X and the normal
initisialization of the console?

Danny




- -- 
"I teleported home one night
With Ron and Sid and Meg.
Ron stole Meggie's heart away
And I got Sidney's leg."

- -- A poem about matter transference beams. 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9QrpHaeiN+EU2vEIRAqSrAKCU5vnbVwwvi1d8gDjCHywQHUVKTQCcCtuu
h5QyGnekikDHOuw/TopYnRA=
=GqpX
-----END PGP SIGNATURE-----

