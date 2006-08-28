Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751562AbWH1WLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbWH1WLe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 18:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751567AbWH1WLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 18:11:34 -0400
Received: from mga03.intel.com ([143.182.124.21]:5536 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751559AbWH1WLd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 18:11:33 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,177,1154934000"; 
   d="scan'208"; a="108760990:sNHT17605245"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] Linux 2.6.17.11 - fix compilation error on IA64 (try #3)
Date: Mon, 28 Aug 2006 15:11:31 -0700
Message-ID: <617E1C2C70743745A92448908E030B2A72869D@scsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Linux 2.6.17.11 - fix compilation error on IA64 (try #3)
Thread-Index: AcbIHlq2qpVQwBENTSiw1PFSmB16cQC0BSvQ
From: "Luck, Tony" <tony.luck@intel.com>
To: "Fernando Vazquez" <fernando@oss.ntt.co.jp>, <gregkh@suse.de>
Cc: <dev@openvz.org>, <xemul@openvz.org>, <davem@davemloft.net>,
       <linux-kernel@vger.kernel.org>, <stable@kernel.org>, <akpm@osdl.org>,
       <linux-ia64@vger.kernel.org>, <kamezawa.hiroyu@jp.fujitsu.com>
X-OriginalArrivalTime: 28 Aug 2006 22:11:32.0131 (UTC) FILETIME=[EB0F3F30:01C6CAEE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The commit 8833ebaa3f4325820fe3338ccf6fae04f6669254 introduced a change that broke 
> IA64 compilation as shown below:

What happened to the mainline version of the patch to which this
is a fix (local DoS with corrupted ELFs)?  I don't see it in 2.6.18-rc5.
Did it get fixed some other way, or is it just queued somewhere?  Or do
we have a fix in -stable that isn't in mainline?

-Tony
