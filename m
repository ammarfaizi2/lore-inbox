Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272048AbTG2Uf3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 16:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272066AbTG2Uf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 16:35:29 -0400
Received: from c52038.upc-c.chello.nl ([212.187.52.38]:44932 "EHLO
	lintilla.koffie.nu") by vger.kernel.org with ESMTP id S272048AbTG2UfY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 16:35:24 -0400
Message-ID: <XFMail.20030729223514.huysmans@xs4all.nl>
X-Mailer: XFMail 1.5.2 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
Date: Tue, 29 Jul 2003 22:35:14 +0200 (CEST)
Organization: JBS Unix Solutions
From: Jan Huijsmans <huysmans@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test 2 & matroxfb or orinoco wifi card
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

After digging a bit in the archives I couldn't find the solution to my problem,
so I'm asking you guys.

I found the "matroxfb and 2.6.0-test2" thread, so it's possible to compile the
kernel with the matrox framebuffer, but I can't find what I'm missing. Did I
forget to set a config option (all copied from the 2.4.21 config except the
nForce2 agp chipset)?

This is the error I'm getting while linking. 

drivers/built-in.o(.text+0x89c80): In function `matroxfb_set_par':
: undefined reference to `default_grn'
drivers/built-in.o(.text+0x89c85): In function `matroxfb_set_par':
: undefined reference to `default_blu'
drivers/built-in.o(.text+0x89c93): In function `matroxfb_set_par':
: undefined reference to `color_table'
drivers/built-in.o(.text+0x89c9b): In function `matroxfb_set_par':
: undefined reference to `default_red'

I would suspect I'm missing libraries, but I don't know which set. I'm runnig
with a dabian sarge distro, the system has an Athlon XP CPU, with asus A7N8X-X
mainboard, matrox G550 graphics card.

Could someone point me in the right direction to get this working?

---

Jan Huijsmans              kernel@koffie.nu

... cannot activate /dev/brain, no response from main coffee server


