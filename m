Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264365AbTLESLF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 13:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264375AbTLESLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 13:11:04 -0500
Received: from 149106.vserver.de ([62.75.149.106]:48827 "EHLO
	149106.vserver.de") by vger.kernel.org with ESMTP id S264365AbTLESJU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 13:09:20 -0500
From: Ralf Orlowski <ralf@orle.de>
Reply-To: ralf@orle.de
Organization: privat
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: crypto support in kernel 2.4.23
Date: Fri, 5 Dec 2003 19:09:07 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312051909.07265.ralf@orle.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

can someone tell me, how I can get the crypto support to work in kernel
2.4.23.

When I try to use this, the kernel compiles just fine with crypto activated
in the configuration. But when I then try to load the modules I always get
these error-messages:

/lib/modules/2.4.23/kernel/crypto/twofish.o: unresolved symbol
crypto_unregister_alg
/lib/modules/2.4.23/kernel/crypto/twofish.o: unresolved symbol
crypto_register_alg
/lib/modules/2.4.23/kernel/crypto/twofish.o: insmod
/lib/modules/2.4.23/kernel/crypto/twofish.o failed
/lib/modules/2.4.23/kernel/crypto/twofish.o: insmod twofish failed

Does someone know, what is missing here? I couldn't find any documentation,
that already mentions this problem.


Bye

Ralf
-- 
Ralf Orlowski                           voice: +49-4122-977356
Katzhagen 98                            mobil: +49-173-5239069
25436 Uetersen                          E-mail: Ralf@orle.de
GERMANY             PGP 5.0 Key available at public keyservers

