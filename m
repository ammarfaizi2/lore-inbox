Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289858AbSBXQtq>; Sun, 24 Feb 2002 11:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289880AbSBXQtg>; Sun, 24 Feb 2002 11:49:36 -0500
Received: from relay01.cablecom.net ([62.2.33.101]:48934 "EHLO
	relay01.cablecom.net") by vger.kernel.org with ESMTP
	id <S289858AbSBXQtW>; Sun, 24 Feb 2002 11:49:22 -0500
Message-ID: <3C79198D.B4161A96@bluewin.ch>
Date: Sun, 24 Feb 2002 17:49:17 +0100
From: Otto Wyss <otto.wyss@bluewin.ch>
Reply-To: otto.wyss@bluewin.ch
X-Mailer: Mozilla 4.78 (Macintosh; U; PPC)
X-Accept-Language: de,en
MIME-Version: 1.0
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Kernel panic: Loop 1 (aic7xxx driver)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since kernel version 2.4.9 I haven't compiled a kernel until recently. With
2.4.17 I always got the "Kernel panic: Loop 1" from the aic7xxx driver. When I
removed this driver the kernel started correctly. My research on the net showed
that "Gregoire Favre (Kernel panic: Loop 1 (aic7xxx under 2.4.13-ac[246]))" has
the same problem as I and his report is almost exactly as mine. I won't write
mine here since I don't know how to save it into a file, anything is lost after
the hard reset (does anybody know how to save/retrieve kernel messages after a panic?).

Well but I can give a hint where to look for since the problem disappears when I
compile the aic7xxx driver into the kernel. If (with make menuconfig) the option
"SCSI support" and the low level driver "Adaptec aic7xxx support" is set to "M"
the problem occurs. It occurs only if the option _"SCSI support"_ is set to "M".
I guess only very few people use this option.

O. Wyss

-- 
Author of "Debian partial mirror synch script"
("http://dpartialmirror.sourceforge.net/")
