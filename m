Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266582AbUIWQMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266582AbUIWQMF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 12:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266488AbUIWQMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 12:12:03 -0400
Received: from fmr05.intel.com ([134.134.136.6]:25218 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S266561AbUIWQLL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 12:11:11 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: 2.6.9-rc2-mm2
Date: Thu, 23 Sep 2004 09:10:45 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F020ED221@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.9-rc2-mm2
Thread-Index: AcShNj8Pq4umpBHIQFKZKo+HFnJlbAAUIpow
From: "Luck, Tony" <tony.luck@intel.com>
To: "Andrew Morton" <akpm@osdl.org>, "Jesse Barnes" <jbarnes@engr.sgi.com>
Cc: <peterc@gelato.unsw.edu.au>, <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 23 Sep 2004 16:10:47.0135 (UTC) FILETIME=[E2D2F6F0:01C4A187]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>It looks like Tony is wearing the BPB.  The below patch from
                                   ^^^?
Huh?  I can tell from context that this is all my fault (to which
I agree; it is), but what does "BPB" stand for?

>Process question: how is it possible that the ia64 tree could have been
>this dead for this long?

Because we have immense confusion about which combinations of
config options (NUMA, DISCONTIG, VIRTUAL_MEM_MAP, SMP) are
supported.  Kconfig allows almost any combination of them, but on
any given week only some combinations work.  The patch that broke
things for you came in to fix a problem for Peter.

I'll take a look at this.  Can you post the .config that you
are using.

-Tony
