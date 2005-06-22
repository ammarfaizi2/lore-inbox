Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbVFVPbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbVFVPbO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 11:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbVFVP2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 11:28:30 -0400
Received: from odpn1.odpn.net ([212.40.96.53]:11733 "EHLO odpn1.odpn.net")
	by vger.kernel.org with ESMTP id S261386AbVFVPZR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 11:25:17 -0400
From: "Gabor Z. Papp" <gzp@papp.hu>
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
Cc: "Mark Haverkamp" <markh@osdl.org>, <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>
Subject: Re: 2.4 and aacraid dmesg
References: <60807403EABEB443939A5A7AA8A7458B0152136F@otce2k01.adaptec.com>
Date: Wed, 22 Jun 2005 17:25:11 +0200
Message-ID: <x6ll5276so@gzp>
User-Agent: Gnus/5.110004 (No Gnus v0.4)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Authenticated: gzp1 odpn1.odpn.net a3085bdc7b32ae4d7418f70f85f7cf5f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* "Salyzyn, Mark" <mark_salyzyn@adaptec.com>:

| The message is coming from the PCI subsystem. Yes it is triggered by the
| pending driver load and requesting card pci resources, but such messages
| are usually a result of issues with the Motherboard BIOS or Hardware.

The system is working fine, stable, without errors. I was just
courious about this kernel msg flood.

| on PCI address 03:0d.0 and 03:09.0 are sharing IRQ 4. The 'info' message
| is printed every time the pcibios_enable_device() call is made. The
| interrupt sharing is assigned by the Motherboard BIOS and if you have
| subsequent problems with the operation of the card(s) or the system, you
| should investigate updating the Motherboard BIOS or go into the
| motherboard BIOS setup and see if you can reassign the PCI (IRQ)
| resources.

Okay. The other device at 03:09.0 is a:

Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 08)

| The spurious 8259A interrupt message *may* be viewed as a problem.

I'm getting this sh*t from 2.4.18 or so... I think its another story.

Anyway, I love this 2120S, boots quite slooowly, but works fine and
stable.

Ah, the chip is *very* *very* *very* hot on the card, is that normal?
