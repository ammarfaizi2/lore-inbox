Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264753AbTFQOaa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 10:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264758AbTFQOaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 10:30:30 -0400
Received: from codeblau.walledcity.de ([212.84.209.34]:59143 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id S264753AbTFQOa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 10:30:27 -0400
Date: Tue, 17 Jun 2003 16:44:43 +0200
From: Felix von Leitner <felix-kernel@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: ACPI broken... again!
Message-ID: <20030617144443.GA27558@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.5.70 and above have broken ACPI.  Again.  This is my fifth
machine on which I try ACPI, two notebooks and three desktops, chipsets
from Intel, VIA and SiS, no matter, ACPI still breaks 'em all.

The symptom is that eth0 does not see the others.  /proc/interrupts has
the correct interrupt listed, so it took me a while to suspect ACPI.
agpgart also crashes, and firewire and USB didn't find any devices.

Why oh why is ACPI so horrendously broken?

And more to the point: if it _is_ this broken, why ship it at all?  I
don't recall a single moment where ACPI did anything good for me, only
crashes, data loss and general brokenness.  This may be a technology
fitting Microsoft and Intel PCs, but why give it even more leverage by
supporting it in Linux?  I say rip this abomination right out of the
kernel and be done with it.

Felix
