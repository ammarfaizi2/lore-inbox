Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261568AbSLCPMf>; Tue, 3 Dec 2002 10:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261573AbSLCPMe>; Tue, 3 Dec 2002 10:12:34 -0500
Received: from service.sh.cvut.cz ([147.32.127.214]:16597 "EHLO
	service.sh.cvut.cz") by vger.kernel.org with ESMTP
	id <S261568AbSLCPMd>; Tue, 3 Dec 2002 10:12:33 -0500
Date: Tue, 3 Dec 2002 16:18:19 +0100 (CET)
From: Martin Kacer <M.Kacer@sh.cvut.cz>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Compile errors in 2.5.50 (bttv, mpu401, fb)
Message-ID: <Pine.LNX.4.21.0212031610010.15302-100000@nightmare.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

I tried 2.5.50 yesterday and encountered three compile errors. One of them
(bttv-driver) was already discussed here, I know nothing about the other
two.

Sorry if it was already reported, I do not read the mailing list very
carefuly. :-)

Also sorry that I have no time now to make patches. And, in fact, I am not
able to do so (excpet the second one VERY SIMPLE case), since I do not
know what the source should be.

1) drivers/media/video/bttv-cards.c - AUDC_CONFIG_PINNACLE constant
- already known and patched!

2) sound/oss/mpu401.h - line #10
return type of the function is void in the header but should be int
according the actual source file

3) include/video/fbcon.h - line #666 (and neighbouring)
non-existant members of struct display are referenced

Good luck...
   - M -

