Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbVILQAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbVILQAO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 12:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbVILQAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 12:00:14 -0400
Received: from fmr15.intel.com ([192.55.52.69]:28039 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750763AbVILQAM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 12:00:12 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: new asm-offsets.h patch problems
Date: Mon, 12 Sep 2005 09:00:06 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F045A9188@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: new asm-offsets.h patch problems
Thread-Index: AcW3HPHonUJAnD1MT3iBFhnKtoJxGwAlD7rQ
From: "Luck, Tony" <tony.luck@intel.com>
To: "Sam Ravnborg" <sam@ravnborg.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 Sep 2005 16:00:08.0492 (UTC) FILETIME=[0C6546C0:01C5B7B3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So I still don't understand what is really happening here.

I left my build script running overnight ... working on a
kernel at the 357d596bd... commit (where Linus merged in
my tree last night).  This one has your "archprepare" patch
already included.

Sometimes a build for a config succeeds, and sometimes it
fails. (tiger_defconfig for the last six builds has had a
GOOD, BAD, BAD, BAD, GOOD, GOOD sequence, while bigsur_defconfig
went GOOD, BAD, BAD, BAD, BAD, BAD).  This non-determinism
doesn't fit in well with your explanation of missing defines
for PAGE_SIZE etc.

-Tony
