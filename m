Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbVDURnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbVDURnT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 13:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbVDURnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 13:43:17 -0400
Received: from fmr15.intel.com ([192.55.52.69]:13250 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S261586AbVDURmF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 13:42:05 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [Gelato-technical] Re: Serious performance degradation on a RAID with kernel 2.6.10-bk7 and later
Date: Thu, 21 Apr 2005 10:41:52 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F0350B3F4@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Gelato-technical] Re: Serious performance degradation on a RAID with kernel 2.6.10-bk7 and later
Thread-Index: AcVGmE+Ltag9dIibTS+sr+iPzg0QpAAAEI9g
From: "Luck, Tony" <tony.luck@intel.com>
To: <davidm@hpl.hp.com>
Cc: <akpm@osdl.org>, "Andreas Hirstius" <Andreas.Hirstius@cern.ch>,
       "Bartlomiej ZOLNIERKIEWICZ" <Bartlomiej.Zolnierkiewicz@cern.ch>,
       "Gelato technical" <gelato-technical@gelato.unsw.edu.au>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Apr 2005 17:41:50.0186 (UTC) FILETIME=[65CDE4A0:01C54699]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Yeah, I'm facing the same issue.  I started playing with git last
>night.  Apart from disk-space usage, it's very nice, though I really
>hope someone puts together a web-interface on top of git soon so we
>can seek what changed when and by whom.

Disk space issues?  A complete git repository of the Linux kernel with
all changesets back to 2.4.0 takes just over 3G ... which is big compared
to BK, but 3G of disk only costs about $1 (for IDE ... if you want 15K rpm
SCSI, then you'll pay a lot more).  Network bandwidth is likely to be a
bigger problem.

There's a prototype web i/f at http://grmso.net:8090/ that's already looking
fairly slick.

-Tony
