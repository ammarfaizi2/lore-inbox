Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262444AbVA0DI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbVA0DI1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 22:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbVAZXLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:11:41 -0500
Received: from smtp.mundo-r.com ([212.51.32.236]:59325 "EHLO smtp.mundo-r.com")
	by vger.kernel.org with ESMTP id S262436AbVAZRPM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 12:15:12 -0500
Date: Wed, 26 Jan 2005 18:16:03 +0100
From: Xose Manuel Fernandez Lorenzo <jm.fernandez@audasa.es>
Subject: Lousing interrupt with Geode
To: linux-kernel@vger.kernel.org
Message-id: <1106759763.489.13.camel@localhost.localdomain>
MIME-version: 1.0
X-Mailer: Evolution 2.0.3
Content-type: text/plain
Content-transfer-encoding: 7bit
X-Antirelay: Good relay from local net2 192.168.0.0/24
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a IAC-H553 Board with a NS Geode Low-Power CPU:

Working around Cyrix MediaGX virtual DMA bugs.
Enable Memory-Write-back mode on Cyrix/NSC processor.
Enable Memory access reorder on Cyrix/NSC processor.
Enable Incrementor on Cyrix/NSC processor.
CPU:     After all inits, caps: 00808131 00818131 00000000 00000001
CPU: Cyrix Geode(TM) Integrated Processor by National Semi stepping 02
Checking 'hlt' instruction... OK.

with a chipset CS5530A Geode.

I have also a Digital Input Output card, and I have develop a board to
generate an interrupt when and input change.

This has been working under MS-DOS properly, but in Linux i lose some
interrupt (I do not get my isr routine called and in /proc/interrupts
the counter do not increment). 

If I use the same Digital Input Output card whit another CPU and linux
everithing work property.

Have someone find the same problem with Geode?

I use the kernel 2.6.5 from debian with Preemtive.

I am nos suscribe to the kernel list, so please response also to my
email.

Thanks in advance


