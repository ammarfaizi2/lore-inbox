Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265947AbTAULSg>; Tue, 21 Jan 2003 06:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266970AbTAULSg>; Tue, 21 Jan 2003 06:18:36 -0500
Received: from rzaixsrv2.rrz.uni-hamburg.de ([134.100.32.71]:53726 "EHLO
	rzaixsrv2.rrz.uni-hamburg.de") by vger.kernel.org with ESMTP
	id <S265947AbTAULSf> convert rfc822-to-8bit; Tue, 21 Jan 2003 06:18:35 -0500
Date: Tue, 21 Jan 2003 12:27:30 +0100
From: Markus Barenhoff <barenh_m@informatik.haw-hamburg.de>
To: Sampson Fung <sampson106@i-cable.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem 2.5.59:SiS framebuffer failed to compile while Intel810 is OK.
Message-ID: <20030121112730.GA864@aliosnet.de>
Mail-Followup-To: Sampson Fung <sampson106@i-cable.com>,
	linux-kernel@vger.kernel.org
References: <00cd01c2bfda$df42fc00$febca8c0@noelpc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <00cd01c2bfda$df42fc00$febca8c0@noelpc>
User-Agent: Mutt/1.4i
X-Url: <http://www.barenhoff.net/>
X-PGP-Key: http://www.barenhoff.net/mbarenh.gpg
X-Mailer: Mutt 1.4i ( i586 Linux 2.4.20-ac2 )
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spake Sampson Fung (sampson106@i-cable.com):

> I tested Intel810fb in kernel 2.5.59 with a success result.  MPlayer can
> use fb to play vcd on my Intel Mainboard now.
> 
> Then, I want to test the DVD playback in my SiS mainboard that has a DVD
> drive installed.  So I modify the .config to include SiS Framebuffer
> support and failed to compile with errors below:
> =================
> 
[sniped the build output]

The problem is, that the driver yet not been ported to the new
framebuffer layer of 2.5. 

The maintainer of the driver writes on his site
(http://www.webit.at/~twinny/linuxsis630.shtml): 
"Kernel 2.5 support will have to wait a few weeks, it seems the fb
API is still under development."

greetz Markus 

-- 
Markus Barenhoff - Spannskamp 26 - D-22527 Hamburg - Germany
Cell: +49-179-8863351 eMail: barenh_m@informatik.haw-hamburg.de 
pgp key: http://www.barenhoff.net/mbarenh.gpg (keyID:0xAE7C7759)
FingerPrint: 79 64 AA D9 B7 16 F5 06  6A 88 5F A9 4D 49 45 BB
