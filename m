Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263059AbVF3VxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263059AbVF3VxM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 17:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263054AbVF3VxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 17:53:12 -0400
Received: from smtp2.poczta.interia.pl ([213.25.80.232]:53162 "EHLO
	smtp.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S263059AbVF3Vvu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 17:51:50 -0400
Date: Thu, 30 Jun 2005 23:51:44 +0200
From: Sebastian Pigulak <dreamin@interia.pl>
To: linux-kernel@vger.kernel.org
Subject: atxp1 module not compiling
Message-ID: <20050630235144.3f563a01@DreaM.darnet>
Organization: arch
X-Mailer: Sylpheed-Claws 1.9.9 (GTK+ 2.6.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
X-EMID: fae5d064
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
Startuj z INTERIA.PL! >>> http://link.interia.pl/f186c 

