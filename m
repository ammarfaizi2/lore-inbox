Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263997AbRFPXQt>; Sat, 16 Jun 2001 19:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264025AbRFPXQ3>; Sat, 16 Jun 2001 19:16:29 -0400
Received: from adsl-64-175-255-50.dsl.sntc01.pacbell.net ([64.175.255.50]:47234
	"HELO kobayashi.soze.net") by vger.kernel.org with SMTP
	id <S263997AbRFPXQI>; Sat, 16 Jun 2001 19:16:08 -0400
Date: Sat, 16 Jun 2001 16:17:33 -0700 (PDT)
From: Justin Guyett <justin@soze.net>
X-X-Sender: <tyme@gw.soze.net>
To: <linux-kernel@vger.kernel.org>
Cc: <twoller@crystal.cirrus.com>, <nils@kernelconcepts.de>
Subject: [bug] apm and cs46xx sound
Message-ID: <Pine.LNX.4.33.0106161612430.23170-100000@gw.soze.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a pretty minor nitpick...

hardware: ibm thinkpad t21 using the apm driver

With 2.4.5-ac13, unplugging from AC, reconnecting to AC no longer causes
sound to be scratchy/garbled, but if something already has /dev/sound/dsp
open and AC state changes, the sound is garbled until the program reopens
the device (usually requires restarting the program e.g. mpg123).

At last, though, i don't have to rmmod and insmod.  That at least is a
relief.


Justin

