Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131047AbRBEUsn>; Mon, 5 Feb 2001 15:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131606AbRBEUsd>; Mon, 5 Feb 2001 15:48:33 -0500
Received: from d231.as5200.mesatop.com ([208.164.122.231]:17032 "HELO
	localhost.localdomain") by vger.kernel.org with SMTP
	id <S131047AbRBEUsU>; Mon, 5 Feb 2001 15:48:20 -0500
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
Date: Mon, 5 Feb 2001 13:50:55 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, jmd@turbogeek.com
Subject: [PATCH] 2.4.1-ac3 CONFIG_INPUT documentation in Configure.help
MIME-Version: 1.0
Message-Id: <01020513505500.02799@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch which adds documentation for CONFIG_INPUT to Configure.help.

Now, only  496 undocumented config options in the 2.4.1-ac3 tree left to go,
out of a total of 1982, of which 40 are apparently unused.

This patch applies to 2.4.1-ac3.

Steven

--- linux/Documentation/Configure.help.orig     Mon Feb  5 12:07:46 2001
+++ linux/Documentation/Configure.help  Mon Feb  5 13:27:13 2001
@@ -10560,6 +10560,16 @@
 
   If unsure, say Y.
 
+Input core support
+CONFIG_INPUT
+  Say Y here if you want to enable any of the following options for
+  USB Human Interface Device (HID) support.
+
+  Say Y here if you want to enable any of the USB HID options in the
+  USB support section which require Input core support.
+
+  Otherwise, say N.
+
 Keyboard support
 CONFIG_INPUT_KEYBDEV
   Say Y here if you want your USB HID keyboard (or an ADB keyboard
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
