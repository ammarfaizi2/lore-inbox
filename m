Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbTJABXH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 21:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbTJABXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 21:23:07 -0400
Received: from fmr09.intel.com ([192.52.57.35]:3810 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S261838AbTJABXE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 21:23:04 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH] deal with lack of acpi prt entries gracefully
Date: Tue, 30 Sep 2003 21:22:59 -0400
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC873D@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] deal with lack of acpi prt entries gracefully
Thread-Index: AcN4sgA1vbyWCHpcS4W+0TmuWOwNNQPB0KCQ
From: "Brown, Len" <len.brown@intel.com>
To: "Jesse Barnes" <jbarnes@sgi.com>,
       "Andrew de Quincey" <adq_dvb@lidskialf.net>
Cc: "Grover, Andrew" <andrew.grover@intel.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 01 Oct 2003 01:23:01.0391 (UTC) FILETIME=[8E14F1F0:01C387BA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Jesse Barnes [mailto:jbarnes@sgi.com] 
> Sent: Thursday, September 11, 2003 6:05 PM
> To: Andrew de Quincey
> Cc: Grover, Andrew; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] deal with lack of acpi prt entries gracefully
> 
> 
> On Thu, Sep 11, 2003 at 11:00:30PM +0100, Andrew de Quincey wrote:
> > > None of the above.  We have our own NUMAlink based 
> interrupt protocol
> > > model.
> > 
> > Oooer! Hmm, the existing code would probably NOT like 
> having _PRT entries for 
> > a model it doesn't know about.... you could add support for 
> it fairly easily 
> > though I suppose...
> 
> Yeah, that's what Andy suggested too.  I guess I have to use 
> one of the
> reserved fields and try to get the ACPI spec updated.
> 
> Thanks,
> Jesse

Even if this exotic box shouldn't be running this flavor of the code,
the inifinite loop part struck me as less than bomb proof;-)
So I pulled the return on count==0 check into the ACPI patch.

Thanks,
-Len
