Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269243AbUJKUt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269243AbUJKUt7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 16:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269242AbUJKUt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 16:49:59 -0400
Received: from fmr05.intel.com ([134.134.136.6]:59306 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S269245AbUJKUtn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 16:49:43 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] 2.6 SGI Altix I/O code reorganization
Date: Mon, 11 Oct 2004 13:49:31 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F022BEF32@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.6 SGI Altix I/O code reorganization
Thread-Index: AcSvufDa4tLmDIjDSZG0BLQ2KPeNKwAGTBSw
From: "Luck, Tony" <tony.luck@intel.com>
To: "Patrick Gefre" <pfg@sgi.com>
Cc: "Colin Ngam" <cngam@sgi.com>, "Jesse Barnes" <jbarnes@engr.sgi.com>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 11 Oct 2004 20:49:36.0251 (UTC) FILETIME=[D196FCB0:01C4AFD3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>We came to a resolution on the pci_root-ops issue, Jesse is OK 
>with the code, Jes and Christoph are 
>fine with the qla mod. I've added a couple of fixes from us as 
>well as removing a redundant check 
>pointed out in the review - see the full list below. So the 
>code is ready to go.
>
>Can you take this now Tony ?

Yes.  I applied those seven changesets to an local tree.  If any other
bug fixes turn up between now and 2.6.9-final you can send an 008-patch
that sits on top of those.

Yesterday on LKML Linus says he's aiming for 2.6.9 in a week or so.
When that happens I'll pull this into my tree and push to him (I don't
want to put it into my bkbits tree yet ... just in case I have some
other critical patch for ia64 that needs to go into 2.6.9).

-Tony
