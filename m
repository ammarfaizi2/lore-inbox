Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264156AbTFPTB5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 15:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264178AbTFPTB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 15:01:57 -0400
Received: from mailf.telia.com ([194.22.194.25]:56551 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id S264156AbTFPTBz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 15:01:55 -0400
X-Original-Recipient: <linux-kernel@vger.kernel.org>
Message-ID: <3EEE173A.8040802@telia.com>
Date: Mon, 16 Jun 2003 21:15:06 +0200
From: Peter Lundkvist <p.lundkvist@telia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030527 Debian/1.3.1-2
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.71 go boom
References: <87isr7cjra.fsf@jumper.lonesom.pp.fi> <20030615191125.I5417@flint.arm.linux.org.uk> <87el1vcdrz.fsf@jumper.lonesom.pp.fi> <20030615212814.N5417@flint.arm.linux.org.uk> <87he6qc3bb.fsf@jumper.lonesom.pp.fi> <20030616085403.A5969@flint.arm.linux.org.uk>
In-Reply-To: <20030616085403.A5969@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.74.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> Which was the latest kernel version which didn't show the problem?
> There doesn't seem to be any PCI, PCMCIA or driver model changes
> from 2.5.70-bk12 to 2.5.70-bk13.
> 
> There are changes in:
> 
> 	-bk11 (pci)
> 	-bk10 (pci)
> 	-bk9 (driver model)
> 	-bk4 (pci)
> 	-bk2 (pcmcia)

I get the same problems: cardbus works only if I boot with the card
inserted. If I insert the card later I get two PCI device entries
for the device, and can't get any interrupts from the card (sometimes
the driver complains about the chip not responding (8139too)).
Tested with the following versions (exactly the same behaviour):
   2.5.69-bk10
   2.5.70
   2.5.70-bk2
   2.5.70-bk5
   2.5.70-bk18
   2.5.71

2.5.69-bk9 was OK.

/peter


