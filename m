Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263212AbREWSmh>; Wed, 23 May 2001 14:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263213AbREWSm1>; Wed, 23 May 2001 14:42:27 -0400
Received: from highland.isltd.insignia.com ([195.217.222.20]:9734 "EHLO
	highland.isltd.insignia.com") by vger.kernel.org with ESMTP
	id <S263212AbREWSmO>; Wed, 23 May 2001 14:42:14 -0400
Message-ID: <3B0C04B9.CC0ABF56@insignia.com>
Date: Wed, 23 May 2001 19:43:05 +0100
From: Stephen Thomas <stephen.thomas@insignia.com>
Organization: Insignia Solutions
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-ac13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: Gameport analog joystick broken in 2.4.4-ac13
In-Reply-To: <E152Kbd-0002a1-00@the-village.bc.nu>
Content-Type: multipart/mixed;
 boundary="------------F0DF9FEC1EDB7F5566910979"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F0DF9FEC1EDB7F5566910979
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Managed to get it to fail again, first attempt.  As a control, booting
ac12 detected the joystick OK, as normal.  Attached is the output of
/proc/ioports in the failed session.  Sadly, there is no difference
in the output of /proc/ioports when running ac12.

Stephen
--------------F0DF9FEC1EDB7F5566910979
Content-Type: text/plain; charset=us-ascii;
 name="ioports-2.4.4-ac13"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ioports-2.4.4-ac13"

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0200-0207 : ns558-pnp
0213-0213 : isapnp read
0220-022f : soundblaster
02f8-02ff : serial(auto)
0330-0333 : MPU-401 UART
0376-0376 : ide1
0388-038b : Yamaha OPL3
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0620-0623 : sound driver (AWE32)
0a20-0a23 : sound driver (AWE32)
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
0e20-0e23 : sound driver (AWE32)
f000-f00f : Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]
  f000-f007 : ide0
  f008-f00f : ide1

--------------F0DF9FEC1EDB7F5566910979--

