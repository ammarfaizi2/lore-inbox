Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265581AbTFMXie (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 19:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265583AbTFMXie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 19:38:34 -0400
Received: from fmr01.intel.com ([192.55.52.18]:59866 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S265581AbTFMXid convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 19:38:33 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: e1000 performance hack for ppc64 (Power4)
Date: Fri, 13 Jun 2003 16:52:18 -0700
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E010107D93A@orsmsx402.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: e1000 performance hack for ppc64 (Power4)
Thread-Index: AcMyAnKU0XzTrYR3SGmq2WX57ZZcjAABAyWw
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "Anton Blanchard" <anton@samba.org>, "David S. Miller" <davem@redhat.com>
Cc: <haveblue@us.ibm.com>, <hdierks@us.ibm.com>, <dwg@au1.ibm.com>,
       <linux-kernel@vger.kernel.org>, <milliner@us.ibm.com>,
       <ricardoz@us.ibm.com>, <twichell@us.ibm.com>, <netdev@oss.sgi.com>
X-OriginalArrivalTime: 13 Jun 2003 23:52:19.0006 (UTC) FILETIME=[D32425E0:01C33206]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Why not instead find out if it's possible to have the e1000 
> > fetch the entire cache line where the first byte of the
> > packet resides?  Even ancient designes like SunHME do that.
> 
> Rusty and I were wondering why the e1000 didnt do that exact thing.
> 
> Scott: is it possible to enable such a thing?

I thought the answer was no, so I double checked with a couple of
hardware guys, and the answer is still no.

-scott
