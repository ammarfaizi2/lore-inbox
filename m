Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266017AbUBJRJc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 12:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266024AbUBJRGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 12:06:36 -0500
Received: from fmr99.intel.com ([192.55.52.32]:5288 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S266049AbUBJRFR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 12:05:17 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: HT CPU handling - 2.6.2
Date: Tue, 10 Feb 2004 12:04:56 -0500
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0025250D1@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: HT CPU handling - 2.6.2
Thread-Index: AcPvsqviP1NTkpCBR96oNOQ24QXZNAAQ/g9A
From: "Brown, Len" <len.brown@intel.com>
To: "Hod McWuff" <hod@wuff.dhs.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Feb 2004 17:04:57.0691 (UTC) FILETIME=[02F2F2B0:01C3EFF8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> what if any vestige of a second CPU exists on that
> particular piece of silicon in my other room.
 
The presentations hanging off this page can explain it better than I
can:
http://www.intel.com/technology/hyperthread/index.htm?iid=sr+hyper&

Note that different model processors can implement different degrees of
sharing vs. duplication for different cost/performance.  Linux treats
them all as regular multi-processors with just some fine tuning for
scheduling logical processors vs physical packages.

Cheers,
-Len

