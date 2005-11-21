Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbVKUPJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbVKUPJp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 10:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbVKUPJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 10:09:45 -0500
Received: from usbb-lacimss1.unisys.com ([192.63.108.51]:12045 "EHLO
	usbb-lacimss1.unisys.com") by vger.kernel.org with ESMTP
	id S932303AbVKUPJo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 10:09:44 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: bug in drivers/pci/hotplug/ibmphp_pci.c
Date: Mon, 21 Nov 2005 10:09:36 -0500
Message-ID: <5E735516D527134997ABD465886BBDA61AC13E@USTR-EXCH5.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: bug in drivers/pci/hotplug/ibmphp_pci.c
Thread-Index: AcXsqVL8UBZ/5Ii/TFikGFKn3UgtzACAszAg
From: "Jordan, William P" <William.Jordan@unisys.com>
To: "Greg KH" <greg@kroah.com>
Cc: <gregkh@suse.de>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Nov 2005 15:09:39.0226 (UTC) FILETIME=[97BA77A0:01C5EEAD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> From: Greg KH [mailto:greg@kroah.com]
> Sent: Friday, November 18, 2005 8:14 PM
> 
> Yes it does look like that.  Does changing this solve a problem that
you
> have been seeing?

Actually, I am not running this code at all. I am just trying to
understand PCI. While investigating how the IO base and IO limit
registers are used, I noticed this instance where it was used
inconsistently. I can resubmit it if you like, but I cannot vouch for
the patch.

Bill Jordan
