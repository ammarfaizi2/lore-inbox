Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268954AbRHYIX4>; Sat, 25 Aug 2001 04:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268897AbRHYIXp>; Sat, 25 Aug 2001 04:23:45 -0400
Received: from imo-m09.mx.aol.com ([64.12.136.164]:42456 "EHLO
	imo-m09.mx.aol.com") by vger.kernel.org with ESMTP
	id <S268954AbRHYIXf>; Sat, 25 Aug 2001 04:23:35 -0400
Date: Sat, 25 Aug 2001 04:23:44 -0400
From: schemins@netscape.net (Thunder from the hill)
To: linux-kernel@vger.kernel.org
Subject: emu10k1 driver breakdown in 2.4.9?
Message-ID: <04F07016.7522E748.00A6DFE2@netscape.net>
X-Mailer: Atlas Mailer 1.0
Content-Type: multipart/mixed; boundary=-------4f17ff67523f7284f17ff67523f728
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


---------4f17ff67523f7284f17ff67523f728
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

Hi,

I am running Linux 2.4.9 compiled on gcc-2.95.2 with K6-II optimization and support for the emu10k1 cards, as I'm using a SB Live!. But whenever I play something that does not go straight to the soundcard (e.g. mp3), the program receives a SIGSEGV. No matter which program.
It all worked fine on Linux-2.4.2, so it seems not the players fault.

config.h appended.

Thunder
-- 
---
Woah! I did a "cat /boot/vmlinuz >> /dev/audio", and I think I heard god...



__________________________________________________________________
Your favorite stores, helpful shopping tools and great gift ideas. Experience the convenience of buying online with Shop@Netscape! http://shopnow.netscape.com/

Get your own FREE, personal Netscape Mail account today at http://webmail.netscape.com/

---------4f17ff67523f7284f17ff67523f728
Content-Type: text/plain; charset=iso-8859-1; name="Config.h"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline; filename="Config.h"
Content-Description: Config.h

#ifndef _LINUX_CONFIG_H
#define _LINUX_CONFIG_H

#include <linux/autoconf.h>

#endif

---------4f17ff67523f7284f17ff67523f728--
