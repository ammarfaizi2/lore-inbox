Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWGCWbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWGCWbp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 18:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWGCWbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 18:31:45 -0400
Received: from ara.aytolacoruna.es ([195.55.102.196]:15069 "EHLO
	mx.aytolacoruna.es") by vger.kernel.org with ESMTP id S1751110AbWGCWbo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 18:31:44 -0400
Date: Tue, 4 Jul 2006 00:31:28 +0200
From: Santiago Garcia Mantinan <manty@manty.net>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: awe64 isa pnp ALSA problems since 2.6.17
Message-ID: <20060703223128.GA2423@pul.manty.net>
References: <20060630205703.GA2840@pul.manty.net> <s5hd5cmtx61.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hd5cmtx61.wl%tiwai@suse.de>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The patch should fix the error above.

I have applied your patch, did a make mrproper and then compiled again, I'm
still getting the very same message:

setup_irq: irq handler mismatch
 <c0123883> setup_irq+0xe5/0xfb  <c01bfcb5> pnp_test_handler+0x0/0x6
 <c0123904> request_irq+0x6b/0x8b  <c01bfe75> pnp_check_irq+0xb8/0x12f
 <c01bfcb5> pnp_test_handler+0x0/0x6  <c01c085b> pnp_assign_irq+0xd7/0xf4
 <c01c0aed> pnp_assign_resources+0x1bc/0x23a  <c01c0bcc>
pnp_auto_config_dev+0x6
1/0x8f
 <c01c0c19> pnp_activate_dev+0x1f/0x46  <d08de81b>
snd_sb16_pnp_detect+0x1ae/0x3
4f [snd_sbawe]
 <c01bf3f5> card_probe+0xb1/0x104  <c01bf4c8>
pnp_register_card_driver+0x80/0x90
 <d085a070> alsa_card_sb16_init+0x70/0xae [snd_sbawe]  <c01223c2>
sys_init_modul
e+0x1103/0x1272
 <c01024b3> syscall_call+0x7/0xb 
pnp: Device 00:01.00 activated.
pnp: Device 00:01.02 activated.

Thanks.

Regards...
-- 
Manty/BestiaTester -> http://manty.net
