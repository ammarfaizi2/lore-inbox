Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbTICJlr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 05:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbTICJlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 05:41:47 -0400
Received: from fmr09.intel.com ([192.52.57.35]:39164 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S261804AbTICJlo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 05:41:44 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: Scaling noise
Date: Wed, 3 Sep 2003 05:41:39 -0400
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FCEB@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Scaling noise
Thread-Index: AcNx9bJ+QrZlxOVnRXGMIgvgBWHWuwAB7l/A
From: "Brown, Len" <len.brown@intel.com>
To: "Giuliano Pochini" <pochini@shiny.it>, "Larry McVoy" <lm@bitmover.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 03 Sep 2003 09:41:41.0487 (UTC) FILETIME=[944847F0:01C371FF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Latency is not bandwidth.

Bingo.

The way to address memory latency is by increasing bandwidth and
increasing parallelism to use it -- thus amortizing the latency.  HT is
one of many ways to do this.  If systems are to grow faster at a rate
better than memory speeds, then plan on more parallelism, not less.

-Len
