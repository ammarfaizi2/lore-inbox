Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751004AbWCCXZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbWCCXZE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 18:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbWCCXZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 18:25:04 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:25322 "EHLO
	pd2mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751004AbWCCXZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 18:25:02 -0500
Date: Fri, 03 Mar 2006 17:25:54 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: CDROM support for Promise 20269
In-reply-to: <5Mquh-2mT-97@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4408D082.2070203@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5Mquh-2mT-97@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Treubig wrote:
> I've been working on a problem with Promise 20269 PATA adapter under 
> LibATA that if I attach a CDROM drive, I can not see the drive.  The 
> message log reports that the driver sees the device, but when I'm fully 
> booted, there's no device available.

..

> [  118.621489] scsi4 : pata_pdc2027x
> [  118.643926] ata1(1): WARNING: ATAPI is disabled, device ignored.

Sounds like your problem there.. need to enable ATAPI in your 
libata/PATA kernel configuration?

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

