Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264500AbUG2Mw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbUG2Mw4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 08:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbUG2Mwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 08:52:55 -0400
Received: from smtp1.volja.net ([217.72.64.59]:55058 "EHLO smtp1.volja.net")
	by vger.kernel.org with ESMTP id S264500AbUG2Mws (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 08:52:48 -0400
Subject: Compile error in 2.6.8-rc2-mm1 - rivafb related
From: Grega Fajdiga <Gregor.Fajdiga@guest.arnes.si>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1091105305.11537.6.camel@cable155-82.ljk.voljatel.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 29 Jul 2004 14:52:25 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day,
Please CC me, since I'm not subscribed. 
I just tried to compile 2.6.8-rc2-mm1 and got this error:
drivers/built-in.o(.text+0x7e369): In function `rivafb_probe'::
undefined reference to `riva_create_i2c_busses'
drivers/built-in.o(.text+0x7e4c1): In function `rivafb_probe'::
undefined reference to `riva_delete_i2c_busses'
drivers/built-in.o(.exit.text+0x1ca): In function `rivafb_remove'::
undefined reference to `riva_delete_i2c_busses'
make: *** [.tmp_vmlinux1] Error 1

Config attached. BTW why can't I disable SCSI support in menuconfig? I 
don't really need it.

Thanks,
Grega

