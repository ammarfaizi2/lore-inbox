Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267179AbUGMWes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267179AbUGMWes (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 18:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267188AbUGMWem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 18:34:42 -0400
Received: from smtp2.wanadoo.fr ([193.252.22.29]:55097 "EHLO
	mwinf0201.wanadoo.fr") by vger.kernel.org with ESMTP
	id S267179AbUGMWeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 18:34:15 -0400
Message-ID: <40F4635C.3090003@reolight.net>
Date: Wed, 14 Jul 2004 00:34:04 +0200
From: Auzanneau Gregory <greg@reolight.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: fr, fr-fr, en, en-gb, en-us
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.8-rc1 and before: IO-APIC + DRI + RTL8139 = Disabling Ethernet
 IRQ
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When loading as a module or into kernel, when DRM is loading, I cannot
use my network.

Here is a part of the dmesg:

[drm] Loading R200 Microcode
irq 19: nobody cared!
 [<c010732a>] __report_bad_irq+0x2a/0x8b
 [<c0107414>] note_interrupt+0x6f/0x9f
 [<c0107732>] do_IRQ+0x161/0x192
 [<c0105a00>] common_interrupt+0x18/0x20
handlers:
[<c0245383>] (rtl8139_interrupt+0x0/0x207)
Disabling IRQ #19

For the moment I can disabling IO-ACPI, but I'm thinking to change my
processor with an processor w/HT. So IO-ACPI is enabling by default.

How solve that ?

Thanks in advance,

-- 
Auzanneau Grégory
GPG 0x99137BEE
