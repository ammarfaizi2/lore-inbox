Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263290AbUANTcd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 14:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264454AbUANTbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 14:31:10 -0500
Received: from mail.wp-sa.pl ([212.77.102.105]:50864 "EHLO mail.wp-sa.pl")
	by vger.kernel.org with ESMTP id S264423AbUANT3g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 14:29:36 -0500
Date: Wed, 14 Jan 2004 20:29:29 +0100
From: Mariusz Zielinski <levi@wp-sa.pl>
Subject: Re: BUG: The key "/ ?" on my abtn2 keyboard is dead with kernel 2.6.1
In-reply-to: <20040114182202.GA32081@ucw.cz>
To: Vojtech Pavlik <vojtech@suse.cz>, Andries Brouwer <aebr@win.tue.nl>
Cc: =?iso-8859-1?q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <1@pervalidus.net>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Message-id: <200401142029.33824.levi@wp-sa.pl>
Organization: Wirtualna Polska S.A.
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.5.93
References: <200401111545.59290.murilo_pontes@yahoo.com.br>
 <20040114142445.GA28377@ucw.cz> <20040114182202.GA32081@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Small adjustment:

diff -Nru a/drivers/char/input.h b/drivers/char/input.h
--- a/drivers/char/input.h     2004-01-14 20:23:03.000000000 +0100
+++ b/drivers/char/input.h2    2004-01-14 20:22:37.000000000 +0100
@@ -194,7 +194,7 @@
 #define KEY_102ND              86
 #define KEY_F11                        87
 #define KEY_F12                        88
-#define KEY_ROMANJI            89
+#define KEY_ROMAJI             89
 #define KEY_KATAKANA           90
 #define KEY_HIRAGANA           91
 #define KEY_HENKAN             92

-- 
Mariusz Zielinski
