Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937964AbWLGOgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937964AbWLGOgK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 09:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937965AbWLGOgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 09:36:10 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:4752 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937964AbWLGOgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 09:36:07 -0500
Date: Thu, 7 Dec 2006 15:36:03 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Andi Kleen <ak@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz,
       "Hack inc." <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [0/5] PCI MMConfig per-chipset support
Message-ID: <20061207143603.GA41804@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Andi Kleen <ak@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz,
	"Hack inc." <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Done in 5 steps, at Andi's very reasonable request:

1/5: PCI MMConfig: Share what's shareable.
  Share code between i386 and x86-64

2/5: PCI MMConfig: Only call unreachable_devices() when type 1 is available.
  Trivial fix.

3/5: PCI MMConfig: Only map what's necessary.
  Trivial fix too.

4/5: PCI MMConfig: Detect and support the E7520 and the 945G/GZ/P/PL
  The actual per-chipset support.

5/5: PCI MMConfig: Reserve resources but only when we're sure about them.
  Add the resources in /proc/iomem when the chipset in known.

  OG.

