Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbTLNRgI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 12:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbTLNRgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 12:36:08 -0500
Received: from pD9E46DC4.dip.t-dialin.net ([217.228.109.196]:48138 "EHLO
	single7.hn.org") by vger.kernel.org with ESMTP id S262280AbTLNRgF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 12:36:05 -0500
From: Nicolai Lissner <nlissne@linux01.gwdg.de>
To: linux-kernel@vger.kernel.org
Subject: Problem with ASUS-A7V600 (was: test11: fd0 with msdos showing garbage)
Date: Sun, 14 Dec 2003 18:36:00 +0100
User-Agent: KMail/1.5.4
References: <200312132302.36999.nlissne@linux01.gwdg.de> <Pine.LNX.4.58.0312131420350.1855@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312131420350.1855@home.osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_B+J3/Wrs9c/ltfI"
Message-Id: <200312141836.01942.nlissne@linux01.gwdg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_B+J3/Wrs9c/ltfI
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Good news : )  it's not test11 that fails...

Sorry to say: This have been some sort of false alarm - 
although the problem still exists.

When I wrote "the disk is readed perfectly with kernel 2.4.x" I referred to 
tests on another machine that is running with kernel 2.4.23.

This other machine reads the disk perfectly even with test11 - 
so this is not a fd-problem of test11...
...it's a problem related to my hardware.

The "problem-machine" - with a mainboard ASUS A7V600 - does show the same 
disk-problems with kernel 2.4.x - probably because there is no support for 
the VIA KT600 chipset used on the board yet. I have experienced also problems 
with the serial port of the board that might or might not be related to the 
lack of support for the chipset.

I have attached the output of lspci (only the lines that are directly related 
to the mainboard itself)

Nicolai

--Boundary-00=_B+J3/Wrs9c/ltfI
Content-Type: text/plain;
  charset="iso-8859-1";
  name="lspci"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspci"

00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge (rev 80)
00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b198
00:0a.0 Ethernet controller: Digital Equipment Corporation DECchip 21040 [Tulip] (rev 23)
00:0f.0 RAID bus controller: VIA Technologies, Inc.: Unknown device 3149 (rev 80)
00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 81)
00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 81)
00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 81)
00:10.3 USB Controller: VIA Technologies, Inc. USB (rev 81)
00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3227
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235 AC97 Audio Controller (rev 60)

--Boundary-00=_B+J3/Wrs9c/ltfI--

