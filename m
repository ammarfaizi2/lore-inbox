Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270857AbTHKCIV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 22:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270861AbTHKCIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 22:08:20 -0400
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:37650 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S270857AbTHKCIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 22:08:19 -0400
Date: Sun, 10 Aug 2003 23:08:30 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: <vlad@lrsehosting.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Modules fail to build / install in 2.6.0-test3
Message-Id: <20030810230830.54717313.vmlinuz386@yahoo.com.ar>
In-Reply-To: <015b01c35faa$585fac90$0200a8c0@wsl3>
References: <015b01c35faa$585fac90$0200a8c0@wsl3>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
