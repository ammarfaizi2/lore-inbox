Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316880AbSIIKBm>; Mon, 9 Sep 2002 06:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316857AbSIIKBc>; Mon, 9 Sep 2002 06:01:32 -0400
Received: from smtpout.mac.com ([204.179.120.89]:64467 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S316878AbSIIKB1>;
	Mon, 9 Sep 2002 06:01:27 -0400
Message-Id: <200209091006.g89A6AZH010180@smtp-relay02.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 4/10 sound/oss/v_midi.h
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.33/sound/oss/v_midi.h	Sat Apr 20 18:25:21 2002
+++ linux-2.5-cli-oss/sound/oss/v_midi.h	Tue Aug 13 15:55:26 2002
@@ -3,7 +3,7 @@
 
 	/* State variables */
  	   int opened;
-
+	   spinlock_t lock;
 	
 	/* MIDI fields */
 	   int my_mididev;

