Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267776AbTBVCr7>; Fri, 21 Feb 2003 21:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267781AbTBVCr6>; Fri, 21 Feb 2003 21:47:58 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:60569 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S267776AbTBVCr6>; Fri, 21 Feb 2003 21:47:58 -0500
Message-ID: <3E56E729.7080407@quark.didntduck.org>
Date: Fri, 21 Feb 2003 21:57:45 -0500
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Unused variable warning in ac97_codec.c
Content-Type: multipart/mixed;
 boundary="------------040409020805090907050003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040409020805090907050003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Kill unused variable.

--
				Brian Gerst

--------------040409020805090907050003
Content-Type: text/plain;
 name="ac97-warn-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ac97-warn-1"

--- linux-2.5.62-bk8/sound/pci/ac97/ac97_codec.c	2003-02-21 20:45:12.000000000 -0500
+++ linux/sound/pci/ac97/ac97_codec.c	2003-02-21 21:52:09.000000000 -0500
@@ -2475,7 +2475,6 @@
 int snd_ac97_tune_hardware(ac97_t *ac97, struct pci_dev *pci, struct ac97_quirk *quirk)
 {
 	unsigned short vendor, device;
-	struct ac97_quirk *q;
 
 	pci_read_config_word(pci, PCI_SUBSYSTEM_VENDOR_ID, &vendor);
 	pci_read_config_word(pci, PCI_SUBSYSTEM_ID, &device);

--------------040409020805090907050003--

