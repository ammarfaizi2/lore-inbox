Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264065AbUDBOsA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 09:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264075AbUDBOsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 09:48:00 -0500
Received: from mailout.zma.compaq.com ([161.114.64.105]:28435 "EHLO
	zmamail05.zma.compaq.com") by vger.kernel.org with ESMTP
	id S264065AbUDBOr6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 09:47:58 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: HSG80 entry in drivers/scsi/scsi_scan.c
Date: Fri, 2 Apr 2004 09:47:52 -0500
Message-ID: <A8B003DDA3332A479C0ECCA641F47E6503BE6718@tayexc13.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: HSG80 entry in drivers/scsi/scsi_scan.c
Thread-Index: AcQYsVNhZfWkz2y9RZi40B5L2tyZNwAEBW9g
From: "Dupuis, Chad" <chad.dupuis@hp.com>
To: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>
Cc: <James.Bottomley@HansenPartnership.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 02 Apr 2004 14:47:53.0206 (UTC) FILETIME=[7A412160:01C418C1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, thank you.

Regards,

Chad Dupuis
Hewlett-Packard Company

-----Original Message-----
From: Marcelo Tosatti [mailto:marcelo.tosatti@cyclades.com] 
Sent: Friday, April 02, 2004 7:37 AM
To: Dupuis, Chad
Cc: James.Bottomley@HansenPartnership.com; linux-kernel@vger.kernel.org
Subject: Re: HSG80 entry in drivers/scsi/scsi_scan.c


On Tue, Mar 30, 2004 at 04:40:00PM -0500, Dupuis, Chad wrote:
> Hello,
> 
> I wanted to report that the
> 
> {"DEC","HSG80","*", BLIST_FORCELUN | BLIST_NOSTARTONADD},
> 
> entry in the device_list[] structure in drivers/scsi/scsi_scan.c is 
> incorrect.  It should be
> 
> {"DEC","HSG80","*", BLIST_SPARSELUN | BLIST_LARGELUN | 
> BLIST_NOSTARTONADD}

Hi Chad, 

Mind to write a patch for 2.6 and, as soon as its tested there, we can 
backport it to 2.4.

James should handle this.
