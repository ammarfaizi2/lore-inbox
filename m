Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWFAJfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWFAJfU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 05:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWFAJfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 05:35:20 -0400
Received: from LNeuilly-152-21-64-8.w80-15.abo.wanadoo.fr ([80.15.165.8]:54984
	"EHLO serveur2.macsoft-sa.com") by vger.kernel.org with ESMTP
	id S1750743AbWFAJfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 05:35:19 -0400
Message-ID: <447ED595.2040902@free.fr>
Date: Thu, 01 Jun 2006 11:55:01 +0000
From: "s.a." <sancelot@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060512
X-Accept-Language: fr-fr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: io apic and shared irq questions
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Regarding an embedded realtime system, I have got a communication board
on pci bus .

I would like it's interrupt not being shared (with usb) , because the
component receives an it every 100us and is realtime determinist.
I looked at how was routed IRQ's with the io apic , although it is able
to use 24 irq's, linux always share my PCI boards IRQ with another
component and do not use all the 24 irq's range capability of ioapic.

Do you think it is possible to program the ioapic in order to have a
better irq mapping and avoid this problem and use all the range of
availbale vectors ?

Best Regards
Steph





