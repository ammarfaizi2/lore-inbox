Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbWAQViQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWAQViQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 16:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWAQViQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 16:38:16 -0500
Received: from ind-iport-1.cisco.com ([64.104.129.195]:50954 "EHLO
	ind-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751265AbWAQViP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 16:38:15 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 000 of 5] md: Introduction
Date: Wed, 18 Jan 2006 05:38:12 +0800
Message-ID: <26A66BC731DAB741837AF6B2E29C1017D47EA0@xmb-hkg-413.apac.cisco.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 000 of 5] md: Introduction
Thread-Index: AcYbPoFG1hT232E5T7+cn3cansTrMwAb1Yqg
From: "Lincoln Dale \(ltd\)" <ltd@cisco.com>
To: "Michael Tokarev" <mjt@tls.msk.ru>, "NeilBrown" <neilb@suse.de>
Cc: <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
X-OriginalArrivalTime: 17 Jan 2006 21:38:03.0858 (UTC) FILETIME=[4BEADB20:01C61BAE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Neil, is this online resizing/reshaping really needed?  I understand
> all those words means alot for marketing persons - zero downtime,
> online resizing etc, but it is much safer and easier to do that stuff
> 'offline', on an inactive array, like raidreconf does - safer, easier,
> faster, and one have more possibilities for more complex changes.  It
> isn't like you want to add/remove drives to/from your arrays every
day...
> Alot of good hw raid cards are unable to perform such reshaping too.

RAID resize/restripe may not be so common with cheap / PC-based RAID
systems, but it is common with midrange and enterprise storage
subsystems from vendors such as EMC, HDS, IBM & HP.
in fact, I'd say it's the exception to the rule _if_ an
midrange/enterprise storage subsystem doesn't have an _online_ resize
capability..

personally, I think this this useful functionality, but my personal
preference is that this would be in DM/LVM2 rather than MD.  but given
Neil is the MD author/maintainer, I can see why he'd prefer to do it in
MD. :)


cheers,

lincoln.
