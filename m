Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270832AbTHKCY1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 22:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270833AbTHKCY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 22:24:27 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:22993 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S270832AbTHKCYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 22:24:24 -0400
Reply-To: <vlad@lrsehosting.com>
From: <vlad@lrsehosting.com>
To: "'Gerardo Exequiel Pozzi'" <vmlinuz386@yahoo.com.ar>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Modules fail to build / install in 2.6.0-test3
Date: Sun, 10 Aug 2003 21:20:50 -0500
Message-ID: <000501c35faf$2fb718f0$0200a8c0@wsl3>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
In-Reply-To: <20030810230830.54717313.vmlinuz386@yahoo.com.ar>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ack! No, I missed those, I have updated and am retrying 'make modules &&
make modules_install' now.  Thanks!

--

 /"\                         / For information and quotes, email us at
 \ /  ASCII RIBBON CAMPAIGN / info@lrsehosting.com
  X   AGAINST HTML MAIL    / http://www.lrsehosting.com/
 / \  AND POSTINGS        / vlad@lrsehosting.com
-------------------------------------------------------------------------

-----Original Message-----
From: Gerardo Exequiel Pozzi [mailto:vmlinuz386@yahoo.com.ar]
Sent: Sunday, August 10, 2003 9:09 PM
To: vlad@lrsehosting.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Modules fail to build / install in 2.6.0-test3


On Sun, 10 Aug 2003 20:46:11 -0500, vlad@lrsehosting.com wrote:
>  INSTALL crypto/twofish.ko
>if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.0-test3;
>fi depmod: *** Unresolved symbols in
>/lib/modules/2.6.0-test3/kernel/drivers/block/cryptoloop.ko
>depmod:         loop_register_transfer
>depmod:         loop_unregister_transfer
>depmod: *** Unresolved symbols in
>/lib/modules/2.6.0-test3/kernel/sound/oss/ac97_plugin_ad1980.ko
>depmod:         ac97_unregister_driver
>depmod:         ac97_register_driver
>depmod: *** Unresolved symbols in
>/lib/modules/2.6.0-test3/kernel/sound/oss/ad1889.ko
>depmod:         ac97_probe_codec
>depmod:         ac97_alloc_codec
>depmod:         ac97_read_proc
>depmod:         ac97_release_codec
>depmod: *** Unresolved symbols in
>/lib/modules/2.6.0-test3/kernel/sound/oss/ali5455.ko
>depmod:         ac97_probe_codec
>depmod:         ac97_alloc_codec
>depmod:         ac97_set_dac_rate
>depmod:         ac97_set_adc_rate
>depmod:         ac97_release_codec
>depmod: *** Unresolved symbols in
>/lib/modules/2.6.0-test3/kernel/sound/oss/forte.ko
>depmod:         ac97_probe_codec
>depmod:         ac97_alloc_codec
>depmod:         ac97_read_proc
>depmod:         ac97_release_codec

you have new module utilities installed ?

you can download module-init-tools from
http://www.kernel.org/pub/linux/kernel/people/rusty/modules/


ciao,
 djgera


--
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D


