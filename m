Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVBVVPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVBVVPf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 16:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVBVVPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 16:15:34 -0500
Received: from mailman2.ppco.com ([138.32.33.140]:7401 "EHLO mailman2.ppco.com")
	by vger.kernel.org with ESMTP id S261248AbVBVVPa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 16:15:30 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Problems with 2.6.11-rc4, Opteron server and MPTBase : Round 2
Date: Tue, 22 Feb 2005 15:15:25 -0600
Message-ID: <D821697F08061F4FBB069FA1AAAA92370C44F9@hoexmb7.conoco.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problems with 2.6.11-rc4, Opteron server and MPTBase : Round 2
Thread-Index: AcUZI6BXFtqk2uw+Rhuemw3IFFWfSQ==
From: "Weathers, Norman R." <Norman.R.Weathers@conocophillips.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Feb 2005 21:15:25.0988 (UTC) FILETIME=[A0A89640:01C51923]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, some more information concerning the previous problems with
2.6.11-rc4.

Ok, 2.6.11-rc3 does the exact same thing as 2.6.11-rc4 does, which is
crashes whenever you try and boot up our Opteron based server which has
an LSI MPT Fusion based SCSI card as the primary card.  Now comes the
weird part...  It only crashes if the mptbase and mptscsih are modules.
If the drivers are built into the kernel, the 2.6.11-rc3 kernel boots
just fine.  I am going to see if the 2.6.11-rc4 kernel boots as well
when the driver is built in.

Thanks again for any help anyone can give.

Norman Weathers
