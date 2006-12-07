Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163161AbWLGSRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163161AbWLGSRb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 13:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163164AbWLGSRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 13:17:31 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:3233 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163161AbWLGSRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 13:17:30 -0500
Date: Thu, 7 Dec 2006 19:17:26 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Andi Kleen <ak@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz,
       "Hack inc." <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Muli Ben-Yehuda <muli@il.ibm.com>
Subject: [0/5] PCI MMConfig per-chipset support - v2
Message-ID: <20061207181726.GA69863@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Andi Kleen <ak@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz,
	"Hack inc." <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Muli Ben-Yehuda <muli@il.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll try to be less messy this time.

  OG.

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
