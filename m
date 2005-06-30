Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263044AbVF3VuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263044AbVF3VuP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 17:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263050AbVF3VuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 17:50:15 -0400
Received: from smtp2.poczta.interia.pl ([213.25.80.232]:17727 "EHLO
	smtp.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S263044AbVF3VuG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 17:50:06 -0400
Date: Thu, 30 Jun 2005 23:49:53 +0200
From: Sebastian Pigulak <dreamin@interia.pl>
To: linux-kernel@vger.kernel.org
Subject: atxp1 module not compiling
Message-ID: <20050630234953.048516af@DreaM.darnet>
Organization: arch
X-Mailer: Sylpheed-Claws 1.9.9 (GTK+ 2.6.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
X-EMID: f4715064
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

I've tried patching linux-2.6.13-RC1 with patch-2.6.13-rc1-git2 and building atxp1(it allows Vcore voltage changing) into the kernel. Unfortunately, the kernel compilation stops with:

LD      init/built-in.o
LD      vmlinux
drivers/built-in.o(.text+0x92298): In function `atxp1_detect':
: undefined reference to `i2c_which_vrm'
drivers/built-in.o(.text+0x921ae): In function `atxp1_attach_adapter':
: undefined reference to `i2c_detect'
make: *** [vmlinux] B³±d 1
==> ERROR: Build Failed.  Aborting... 

Could someone have a look at the module and possibly fix it up?

----------------------------------------------------------------------
OMNIXMAIL! Jesli masz telefon w sieci Era i dostep do WAP, to mozesz
na komorce odbierac poczte ze wszystkich swoich kont poczty e-mail!
OMNIXMAIL jest w Era Omnix: http://link.interia.pl/f1896

