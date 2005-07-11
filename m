Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262834AbVGKWJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262834AbVGKWJH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 18:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262871AbVGKWHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 18:07:09 -0400
Received: from mail.kroah.org ([69.55.234.183]:59868 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262843AbVGKWDu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 18:03:50 -0400
Cc: vda@ilport.com.ua
Subject: [PATCH] I2C: Coding style cleanups to via686a
In-Reply-To: <1121119376361@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 11 Jul 2005 15:02:56 -0700
Message-Id: <11211193762794@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Content-Transfer-Encoding: 8BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: Coding style cleanups to via686a

On Wednesday 22 June 2005 08:17, Greg KH wrote:
> [PATCH] I2C: Coding style cleanups to via686a
>
> The via686a hardware monitoring driver has infamous coding style at the
> moment. I'd like to clean up the mess before I start working on other
> changes to this driver. Is the following patch acceptable? No code
> change, only coding style (indentation, alignments, trailing white
> space, a few parentheses and a typo).
>
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

Nice.

You missed some. This one is on top of your patch:

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 6328c0e163abfce679b1beffb166f72900bf0a22
tree d5fa7087c5d18b12bd1b93797de2277bddcb6300
parent 200d481f28be4522464bb849dd0eb5f8cb6be781
author Denis Vlasenko <vda@ilport.com.ua> Wed, 22 Jun 2005 10:25:13 +0300
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 11 Jul 2005 14:10:36 -0700

 drivers/i2c/chips/via686a.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c
+++ b/drivers/i2c/chips/via686a.c
@@ -1,9 +1,9 @@
 /*
     via686a.c - Part of lm_sensors, Linux kernel modules
-                for hardware monitoring
+		for hardware monitoring
 
     Copyright (c) 1998 - 2002  Frodo Looijaard <frodol@dds.nl>,
-                        Kyösti Mälkki <kmalkki@cc.hut.fi>,
+			Kyösti Mälkki <kmalkki@cc.hut.fi>,
 			Mark Studebaker <mdsxyz123@yahoo.com>,
 			and Bob Dougherty <bobd@stanford.edu>
     (Some conversion-factor data were contributed by Jonathan Teh Soon Yew
@@ -171,18 +171,18 @@ static inline u8 FAN_TO_REG(long rpm, in
 /******** TEMP CONVERSIONS (Bob Dougherty) *********/
 /* linear fits from HWMon.cpp (Copyright 1998-2000 Jonathan Teh Soon Yew)
       if(temp<169)
-              return double(temp)*0.427-32.08;
+	      return double(temp)*0.427-32.08;
       else if(temp>=169 && temp<=202)
-              return double(temp)*0.582-58.16;
+	      return double(temp)*0.582-58.16;
       else
-              return double(temp)*0.924-127.33;
+	      return double(temp)*0.924-127.33;
 
  A fifth-order polynomial fits the unofficial data (provided by Alex van
  Kaam <darkside@chello.nl>) a bit better.  It also give more reasonable
  numbers on my machine (ie. they agree with what my BIOS tells me).
  Here's the fifth-order fit to the 8-bit data:
  temp = 1.625093e-10*val^5 - 1.001632e-07*val^4 + 2.457653e-05*val^3 -
-        2.967619e-03*val^2 + 2.175144e-01*val - 7.090067e+0.
+	2.967619e-03*val^2 + 2.175144e-01*val - 7.090067e+0.
 
  (2000-10-25- RFD: thanks to Uwe Andersen <uandersen@mayah.com> for
  finding my typos in this formula!)

