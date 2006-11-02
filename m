Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbWKBFMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWKBFMb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 00:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbWKBFMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 00:12:31 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:31909 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750888AbWKBFMa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 00:12:30 -0500
Message-ID: <45497E3A.6060103@garzik.org>
Date: Thu, 02 Nov 2006 00:12:26 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Promise 20319 chipset specs opened
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Promise has given me permission to post hardware programming info for 
one of their chips (Linux driver: sata_promise), PDC20319.  This also 
marks the first open chipset for Promise (AFAIK), so let's give them a 
round of applause.

The PDC20319 is a reasonably representative example of the hardware 
programming interface covered by sata_promise.  Kernel developers 
wishing to work on sata_promise can study this doc, and deduce how the 
two-port PDC2037x chips work.

In addition to describing the "packet" format for ATA and ATAPI 
commands, this doc also describes how to use the chip's XOR RAID-assist 
features.  I think it would be cool if someone so motivated found a way 
to use this efficiently under Linux.

The doc:
	http://gkernel.sourceforge.net/specs/promise/pdc20319.pdf.bz2

I have also updated the list open chipsets and developer resources on 
linux-ata.org:
	http://linux-ata.org/driver-status.html#open_chipsets
	http://linux-ata.org/devel.html

Have fun!

	Jeff


