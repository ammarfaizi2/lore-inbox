Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265531AbTIJTCr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 15:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265530AbTIJTCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 15:02:10 -0400
Received: from fmr09.intel.com ([192.52.57.35]:6909 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S265525AbTIJTBX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 15:01:23 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: ACPI patch flow
Date: Wed, 10 Sep 2003 15:01:06 -0400
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FD58@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ACPI patch flow
Thread-Index: AcN3xa5dNltVssXfTKqZ0S4GwpQqxAAAXpYw
From: "Brown, Len" <len.brown@intel.com>
To: <acpi-devel@lists.sourceforge.net>,
       "Grover, Andrew" <andrew.grover@intel.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Sep 2003 19:01:09.0525 (UTC) FILETIME=[E548A450:01C377CD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've re-named the linux-acpi* tree to be linux-acpi-release*; and made
the staging area for the release tree visible -- calling it
linux-acpi-test*

So a 2 stage release is now visible on the net:

1. linux-acpi-test-*
Staging area for linux-acpi-release-*  This is where to go to try out
the latest integrated patch that is being tested in preparation for push
into the release tree.  In the past this was not visible, and so it
limited the ability of others to test the integrated patch w/o
integrating it all themselves, and led to surprises when changes came
out in the release that people may not have seen on the list.  Exporting
this will also allow me to give contributors quicker feedback when their
changes have entered the release pipeline.

2. linux-acpi-release-*
Same release trees as before, with same usage -- just added "release" to
the name.  As before, whenever we update these and release to 2.4 and
2.6 we'll also post post the plain patch to
http://sourceforge.net/projects/acpi

As before, the BK trees live here:  http://linux-acpi.bkbits.com  If
there is demand for plain patches of the _test_ tree we can probably
also export those on http://sourceforge.net/projects/acpi too, but as
the test tree will change more often, those updates would have to be
on-demand or on significant events.

Thanks,
-Len

Ps. The release tree has always been sync'd with the latest baseline for
each release; and this will still be the case.  But this makes it more
difficult for people to apply the latest patch to older trees.  So now
there is a 2.4.22 tree that is the (frozen) 2.4.22 plus only the ACPI
updates.  I'll apply 2.4 patches there and then push them forward into
the 2.4.23 tree.  We'll do the same with 2.6 when stable 2.6 baselines
emerge.

