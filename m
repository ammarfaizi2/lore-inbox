Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270680AbRHJXKU>; Fri, 10 Aug 2001 19:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270681AbRHJXKD>; Fri, 10 Aug 2001 19:10:03 -0400
Received: from zero.tech9.net ([209.61.188.187]:21256 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S270680AbRHJXJl>;
	Fri, 10 Aug 2001 19:09:41 -0400
Subject: [PATCH] 2.4.7-ac11: Updated emu10k1 driver
From: Robert Love <rml@tech9.net>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 10 Aug 2001 19:10:29 -0400
Message-Id: <997485043.692.23.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Available at http://tech9.net/rml/linux/patch-rml-2.4.7-ac11-emu10k1
(its 190k).

First, I know its big but that is the result of not keeping the driver
in sync for some time now.  Don't blame me, I am not the maintainer.  I
am tired of patching my patched-ac kernel with this patch!

This brings 2.4.7-ac11 to the OSS Creative Open Source driver v0.15
(specifically, a CVS dump from today, 20010810).  The previous version
was v0.7, dating _200008_.

Changes 0.7 -> 0.15:
Uses the kernel ac97, rear speaker volume support, dsp patch support,
AC3 passthru support, support for 5.1 cards, sequencer support, bug
fixes. see linux/drivers/sound/emu10k1/main.c for more details.

Changes from official CVS -> this patch:
* Uses the kernel's Makefile (updated for 0.15)
* Actually uses the kernel's ac97 support from linux/sound

Tested and in use now.

Alan, please consider merging this.  I know it is big but how else will
we ever get it back in sync?  I will work to keep it up to date if it
falls behind again.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

