Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265558AbUAZXdX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 18:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265594AbUAZXdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 18:33:23 -0500
Received: from mail.tmr.com ([216.238.38.203]:29962 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S265558AbUAZXdW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 18:33:22 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.2-rc1 / ACPI sleep / irqbalance / kirqd / pentium 4 HT problems on Uniwill N258SA0
Date: 26 Jan 2004 23:33:03 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bv483f$6va$1@gatekeeper.tmr.com>
References: <20040124233749.5637.COUNT0@localnet.com>
X-Trace: gatekeeper.tmr.com 1075159983 7146 192.168.12.62 (26 Jan 2004 23:33:03 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040124233749.5637.COUNT0@localnet.com>,
Huw Rogers  <count0@localnet.com> wrote:
| Uniwill N258SA0 (http://www.uniwill.com/Product/N258SA0/N258SA0.html) aka
| Hypersonic Aviator NX6, Fujitsu-Siemens AMILO D 1840 Widescreen, etc.).
| SiS 648FX chipset, SiS 900 Ethercard, AMI BIOS, ATI  AV350/M10 128Mb.
| My machine: Hyperthreaded P4 2.8GHz, .5Gb PC3200 RAM.
| 
| Installed Fedora. Upgraded to 2.6.2-rc1 per
| http://thomer.com/linux/migrate-to-2.6.html.
| 
| Applied kernel patches:
| - SiS AGP (http://lkml.org/lkml/2004/1/20/233)
|   (needed to run ATI's 3.7 fglrx drivers on the SiS/M10 combo)
| - ACPI 20031203 (http://acpi.sourceforge.net/)
| 
| All good, but ACPI sleep doesn't work and neither does userland IRQ
| balancing with Arjan's irqbalance (http://people.redhat.com/arjanv/irqbalance/),
| a standard part of the Fedora install.

Let me ask a question which probably has an obvious answer... why do you
care to balance the irq on the siblings of a single CPU? Is there some
hidden value I totally miss?

Noting that WBEL-3.0 balances all of the interrupts *except* NICs, I am
sure I don't understand the benefits of balancing between siblings, but
I'm sure someone will enlighten me.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
