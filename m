Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266276AbUBDCGZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 21:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266275AbUBDCGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 21:06:25 -0500
Received: from fmr09.intel.com ([192.52.57.35]:33213 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S266276AbUBDCEb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 21:04:31 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [Infiniband-general] Getting an Infiniband access layer in the linux kernel
Date: Tue, 3 Feb 2004 18:01:20 -0800
Message-ID: <F595A0622682C44DBBE0BBA91E56A5ED1C3673@orsmsx410.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Infiniband-general] Getting an Infiniband access layer in the linux kernel
Thread-Index: AcPquwK7oNlswVjuRUyx5H9dvCdeTAAA6KVw
From: "Woodruff, Robert J" <woody@co.intel.com>
To: "Greg KH" <greg@kroah.com>, "Woodruff, Robert J" <woody@jf.intel.com>
Cc: "Troy Benjegerdes" <hozer@hozed.org>,
       "Woodruff, Robert J" <woody@jf.intel.com>,
       <infiniband-general@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Feb 2004 02:01:20.0484 (UTC) FILETIME=[C87F3240:01C3EAC2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good I think the InfiniBand community would like to get some of the 
code into 2.6. 

The access layer is all loadable modules and does not require any kernel
changes. 
But we will need to look into integrating it into the build environment 
(and provide a patch for that). 

We will work with the InfiniBand HCA vendors, such as Mellanox and
Fujitsu, to 
get the 2.6 code tested on the hardware and put together a patch that
can be submitted for review by the larger linux community. If you would
like to see the code before we
run it on 2.6, we could possibly do that as well. 


woody


-----Original Message-----
From: Greg KH [mailto:greg@kroah.com] 
Sent: Tuesday, February 03, 2004 5:03 PM
To: Woodruff, Robert J
Cc: Troy Benjegerdes; Woodruff, Robert J;
infiniband-general@lists.sourceforge.net; linux-kernel@vger.kernel.org
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in
the linux kernel


On Tue, Feb 03, 2004 at 04:17:36PM -0800, Woodruff, Robert J wrote:
> 
> I heard from a friend of mine that 2.6 was closed to new features.
> What sayith the community on allowing additional experimental drivers
> (like the infiniband access layer) into 2.6 ? Can we still submit
> something or do we have to wait till 2.7 ?

If it's a subsystem that does not touch any of the existing kernel (with
the exception of adding it to the build and Kconfig), then it probably
will not be a problem to add.

But then again, that all depends on what the code looks like, and none
of us have seen that yet :)

thanks,

greg k-h
