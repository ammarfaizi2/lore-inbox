Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263542AbUCYSzY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 13:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263554AbUCYSzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 13:55:24 -0500
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:23046 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S263542AbUCYSzS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 13:55:18 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6529.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: cciss updates [1 of 2]
Date: Thu, 25 Mar 2004 12:55:15 -0600
Message-ID: <D4CFB69C345C394284E4B78B876C1CF105BC1F61@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: cciss updates [1 of 2]
Thread-Index: AcQShHL/sJGM69cuTyi4RuIv/Rr3cAAFhkuQ
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: <axboe@suse.de>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 25 Mar 2004 18:55:16.0255 (UTC) FILETIME=[B618AAF0:01C4129A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yep, that would the right thing to do. But right now management wants this :(

-----Original Message-----
From: Jeff Garzik [mailto:jgarzik@pobox.com]
Sent: Thursday, March 25, 2004 10:14 AM
To: Miller, Mike (OS Dev)
Cc: axboe@suse.de; linux-kernel@vger.kernel.org
Subject: Re: cciss updates [1 of 2]


mikem@beardog.cca.cpqcorp.net wrote:
> Please consider this change for inclusion in the 2.4 kernel.
> 
> This change is required to support the new MSA30 storage enclosure.
> If you do a SCSI inquiry to a SATA disk bad things happen. This patch prevents 
> the inquiry from going to SATA disks.


I 'ack' both of those patches, but am still curious:  wouldn't you want 
to either (a) simulate an inquiry page via ATA's identify device or (b) 
allow userspace to issue identify device?

	Jeff



