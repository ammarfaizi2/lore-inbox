Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264665AbTA2Vnp>; Wed, 29 Jan 2003 16:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264716AbTA2Vnp>; Wed, 29 Jan 2003 16:43:45 -0500
Received: from postal2.lbl.gov ([131.243.248.26]:44761 "EHLO postal2.lbl.gov")
	by vger.kernel.org with ESMTP id <S264665AbTA2Vnp>;
	Wed, 29 Jan 2003 16:43:45 -0500
Message-ID: <3E384D41.9080605@lbl.gov>
Date: Wed, 29 Jan 2003 13:53:05 -0800
From: Thomas Davis <tadavis@lbl.gov>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021017
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre4
References: <Pine.LNX.4.53L.0301290143350.27119@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.53L.0301290143350.27119@freak.distro.conectiva>
Content-Type: multipart/mixed;
 boundary="------------010206060702030408080103"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------010206060702030408080103
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


This simple one line patch adds the missing ac97 support that the fm801 
driver already uses.

thomas



--------------010206060702030408080103
Content-Type: text/plain;
 name="forte_ac97_codec.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="forte_ac97_codec.diff"

--- linux-2.4.21-pre2/drivers/sound/ac97_codec.c	Tue Dec 24 15:37:53 2002
+++ linux-2.4.20-ac1/drivers/sound/ac97_codec.c	Fri Dec  6 00:07:04 2002
@@ -133,6 +133,7 @@
 	{0x43525931, "Cirrus Logic CS4299 rev A", &crystal_digital_ops},
 	{0x43525933, "Cirrus Logic CS4299 rev C", &crystal_digital_ops},
 	{0x43525934, "Cirrus Logic CS4299 rev D", &crystal_digital_ops},
+	{0x44543031, "Forte Media FM801",       &null_ops},
 	{0x45838308, "ESS Allegro ES1988",	&null_ops},
 	{0x49434511, "ICE1232",			&null_ops}, /* I hope --jk */
 	{0x4e534331, "National Semiconductor LM4549", &null_ops},

--------------010206060702030408080103--

