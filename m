Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbTFDJnq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 05:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbTFDJnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 05:43:46 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:1168 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261864AbTFDJnp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 05:43:45 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16093.49785.273511.76181@gargle.gargle.HOWL>
Date: Wed, 4 Jun 2003 11:57:13 +0200
From: mikpe@csd.uu.se
To: earny@net4u.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rc7 failed boot without Local APIC support
In-Reply-To: <200306040743.14456.earny@net4u.de>
References: <200306040743.14456.earny@net4u.de>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ernst Herzberg writes:
 > The only patch applied is acpi-20030512.
 > 2.4.21-rc2 works without problems.
 > Booting _with_ local APIC enabled works fine, but alsa on VT8233 AC97 does not work.
 > Booting _without_ local APIC:
...
 > PCI: Using ACPI for IRQ routing
 > PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
...
(aic7xxx error messages deleted)

Try again without ACPI. ACPI is known to mess up IRQ routing in some systems.
