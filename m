Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932483AbWCMWAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbWCMWAW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 17:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbWCMWAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 17:00:21 -0500
Received: from fmr21.intel.com ([143.183.121.13]:27554 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S932483AbWCMWAR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 17:00:17 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Exports for hrtimer APIs
Date: Mon, 13 Mar 2006 14:00:16 -0800
Message-ID: <CBDB88BFD06F7F408399DBCF8776B3DC06A48C31@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Exports for hrtimer APIs
Thread-Index: AcZG6YLBK+rLK9tISoCVHEPBYiTB3w==
From: "Stone, Joshua I" <joshua.i.stone@intel.com>
To: "LKML" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 13 Mar 2006 22:00:17.0069 (UTC) FILETIME=[834AF5D0:01C646E9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have noticed that the hrtimer APIs in 2.6.16 RCs are not exported, and
therefore modules are unable to use hrtimers.  I have not seen any
discussion on this point, so I presume that this is either an oversight,
or there has not been any case presented for exporting hrtimers.

I would like to add hrtimer support to SystemTap, which by design
requires the use of dynamically loaded kernel modules.  Can the
appropriate exports for hrtimers please be added?

Thanks,

Josh Stone


- Please CC me in any discussion on this, as I am not subscribed to LKML
