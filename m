Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263063AbTIWW6o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 18:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbTIWW6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 18:58:44 -0400
Received: from fmr09.intel.com ([192.52.57.35]:49873 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S262205AbTIWW6k convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 18:58:40 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: NS83820 2.6.0-test5 driver seems unstable on IA64
Date: Tue, 23 Sep 2003 15:58:29 -0700
Message-ID: <DD755978BA8283409FB0087C39132BD101B01197@fmsmsx404.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: NS83820 2.6.0-test5 driver seems unstable on IA64
Thread-Index: AcOCFhnm1mbxS1MzS1qGXHncNbapLgAD2fHA
From: "Luck, Tony" <tony.luck@intel.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "David S. Miller" <davem@redhat.com>, <davidm@hpl.hp.com>,
       <davidm@napali.hpl.hp.com>, <peter@chubb.wattle.id.au>,
       <bcrl@kvack.org>, <ak@suse.de>, <iod00d@hp.com>,
       <peterc@gelato.unsw.edu.au>, <linux-ns83820@kvack.org>,
       <linux-ia64@vger.kernel.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 23 Sep 2003 22:58:30.0241 (UTC) FILETIME=[34C83510:01C38226]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Maw, 2003-09-23 at 19:21, Luck, Tony wrote:
> > a) the programmer is playing fast and loose with types and/or casts.
> > b) the end-user is going to be disappointed with the performance.
> 
> c) the programmer is being clever and knows the unaligned access is
> cheaper on average than the cost of making sure it cant happen

Which is great until the "cleverly written" program is fed a data set
that pushes into the unaligned case far more frequently than the
programmer anticipated.

> > Looking at a couple of ia64 build servers here I see zero unaligned
> > access messages in the logs.
> 
> Anyone who can deliver network traffic to your box can soon 
> fix that...

See answer above :-)

-Tony Luck
