Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265446AbTFSMl0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 08:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265447AbTFSMl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 08:41:26 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:51941 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S265446AbTFSMlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 08:41:25 -0400
Date: Thu, 19 Jun 2003 14:55:21 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: Problems with IDE on GA-7VAXP motherboard
Message-ID: <20030619125521.GA12711@tc.pci.uni-heidelberg.de>
References: <20030619075434.GA23329@charter.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030619075434.GA23329@charter.net>
User-Agent: Mutt/1.5.3i
From: Bernd Schubert <Bernd.Schubert@tc.pci.uni-heidelberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

have you already looked at the irq's from the lspci output? Especially
the
usage from 16 to 19, for graphics-, sound- and network-card looks a bit
wrong.
>From your kernel-configuration I can see that you have acpi enabled, the
first I would do is booting with acpi=off as kernel option. If you
really need acpi later on, you should try with pci=noacpi or pci=biosirq. Also
consider to use a more recent acpi from acpi.sf.net.

If this doesn't help, I would suggest that you also send some lines from
dmesg-output, so that the real experts can see whats going on with your
irq-routing.

Best regards,
        Bernd
