Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270845AbTHKBuc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 21:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270846AbTHKBuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 21:50:32 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:5538 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S270845AbTHKBua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 21:50:30 -0400
Reply-To: <vlad@lrsehosting.com>
From: <vlad@lrsehosting.com>
To: "Lkml \(E-mail\)" <linux-kernel@vger.kernel.org>
Subject: Modules fail to build / install in 2.6.0-test3
Date: Sun, 10 Aug 2003 20:46:11 -0500
Message-ID: <015b01c35faa$585fac90$0200a8c0@wsl3>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  INSTALL crypto/twofish.ko
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.0-test3; fi
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test3/kernel/drivers/block/cryptoloop.ko
depmod:         loop_register_transfer
depmod:         loop_unregister_transfer
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test3/kernel/sound/oss/ac97_plugin_ad1980.ko
depmod:         ac97_unregister_driver
depmod:         ac97_register_driver
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test3/kernel/sound/oss/ad1889.ko
depmod:         ac97_probe_codec
depmod:         ac97_alloc_codec
depmod:         ac97_read_proc
depmod:         ac97_release_codec
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test3/kernel/sound/oss/ali5455.ko
depmod:         ac97_probe_codec
depmod:         ac97_alloc_codec
depmod:         ac97_set_dac_rate
depmod:         ac97_set_adc_rate
depmod:         ac97_release_codec
depmod: *** Unresolved symbols in
/lib/modules/2.6.0-test3/kernel/sound/oss/forte.ko
depmod:         ac97_probe_codec
depmod:         ac97_alloc_codec
depmod:         ac97_read_proc
depmod:         ac97_release_codec

--

 /"\                         / For information and quotes, email us at
 \ /  ASCII RIBBON CAMPAIGN / info@lrsehosting.com
  X   AGAINST HTML MAIL    / http://www.lrsehosting.com/
 / \  AND POSTINGS        / vlad@lrsehosting.com
-------------------------------------------------------------------------


