Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262810AbSJEXYI>; Sat, 5 Oct 2002 19:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262811AbSJEXYI>; Sat, 5 Oct 2002 19:24:08 -0400
Received: from paloma17.e0k.nbg-hannover.de ([62.181.130.17]:3011 "HELO
	paloma17.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S262810AbSJEXYF> convert rfc822-to-8bit; Sat, 5 Oct 2002 19:24:05 -0400
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.5.40 (-ac3) and 2.4.19-ck5: mousedev interfere with parport ;-(
Date: Sun, 6 Oct 2002 01:29:40 +0200
User-Agent: KMail/1.4.7
Cc: Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200210060129.41010.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While printing with latest hpijs-1.2.2-rss.1 (patched for older HP9xx 
printers) at 1200x1200 DPI on 2.5.40-ac3 I found critical bug in the 
"mousedev" module.

Symptoms:

Total system hang.
Nothing in the logs :-(
Reboot
CUPS restart and boom, again and again,...

Then I went back to 2.4.19-ck5 and boom...
Several hpijs-1.2.1/1.2.2 versions rechecked. -> Nothing.

After some thought.
I have to use "mousedev" and "psmouse" modules since 2.5.40 (-ac3).
Commented both in my "/etc/rc.d/boot.local" file and started 2.4.19-ck5, 
again. Bingo ;-)

But what should I do with 2.5.40+?
I need my mouse.

System:
dual Athlon MP 1900+
MSI MS-6501 (aka K7D Master-L), Rev 1.0, AMD 760MPX

Regards,
	Dieter

BTW 2.5.40 is so GREAT on my mixed server/desktop/3D graphics devel maschine.

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel at hamburg.de (replace at with @)

