Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262694AbTCZXqA>; Wed, 26 Mar 2003 18:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262701AbTCZXqA>; Wed, 26 Mar 2003 18:46:00 -0500
Received: from fmr01.intel.com ([192.55.52.18]:20970 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S262694AbTCZXp7> convert rfc822-to-8bit;
	Wed, 26 Mar 2003 18:45:59 -0500
Message-ID: <A46BBDB345A7D5118EC90002A5072C780B71722A@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'kasper_k_jensen@sol.dk'" <kasper_k_jensen@sol.dk>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Kernel BUG
Date: Wed, 26 Mar 2003 15:57:01 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I think I have found a bug, I have taken a srceen dump of it.

Mar 26 13:38:15 localhost kernel: CPU:    0
Mar 26 13:38:15 localhost kernel: ide-cd cdrom i810_audio ac97_codec
soundcore a
utofs 8139too mii iptable_filter
Mar 26 13:38:15 localhost kernel: invalid operand: 0000
Mar 26 13:38:15 localhost kernel: kernel BUG at page_alloc.c:145!
Mar 26 13:38:15 localhost kernel: ------------[ cut here ]------------
Mar 26 13:38:14 localhost kernel: swap_free: Bad swap file entry 0383304c
Mar 26 13:38:14 localhost kernel: swap_free: Bad swap file entry 050db024

I'd say you also have problems with your swap device ... I'd first make
sure your swap device is ok and then retry - however, the BUG is still
there, that is for sure ...

It'd also help to know your kernel version

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
