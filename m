Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266020AbUBESgh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 13:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266374AbUBESgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 13:36:37 -0500
Received: from fmr09.intel.com ([192.52.57.35]:62081 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S266020AbUBESgf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 13:36:35 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [Infiniband-general] Getting an Infiniband access layer in the linux kernel
Date: Thu, 5 Feb 2004 10:34:50 -0800
Message-ID: <A28EFEDC5416054BA1026D892753E9AF042735CE@orsmsx404.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Infiniband-general] Getting an Infiniband access layer in the linux kernel
Thread-Index: AcPsE8LblUrWmG9cSsedE+ln5UZhbgAAmEpQ
From: "Raj, Ashok" <ashok.raj@intel.com>
To: "Greg KH" <greg@kroah.com>, "Hefty, Sean" <sean.hefty@intel.com>,
       <linux-kernel@vger.kernel.org>
Cc: "Troy Benjegerdes" <hozer@hozed.org>,
       "Woodruff, Robert J" <woody@co.intel.com>,
       "Magro, Bill" <bill.magro@intel.com>,
       "Woodruff, Robert J" <woody@jf.intel.com>,
       <infiniband-general@lists.sourceforge.net>
X-OriginalArrivalTime: 05 Feb 2004 18:35:47.0640 (UTC) FILETIME=[DF4E6B80:01C3EC16]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

I don't think re-implementing was the idea, but the motivation was that
this code was origininally developed for multiple operating environments
such as EFI for preboot, and also some embedded environment. This was
designed to just ease effort in porting.

Iam not sure what you point out that is not done correctly, please help
us understand.

Thanks
ashok

>On Thu, Feb 05, 2004 at 10:01:13AM -0800, Hefty, Sean wrote:
>> As an FYI, the code is available for download on bitkeeper at
>> http://infiniband.bkbits.net/iba.  We're still working on providing a
>> tarball and patch for 2.6, but if you would like to see the code now,
it
>> is available.
>
>Oh, I've seen that code, and still feel ill after looking at some of
>it...
>
>Come on, implementing your own spinlocks (and getting it wrong) and
>atomit_t?  Why in the world would you _ever_ want to do that.
>



>That code needs a _lot_ of cleanup to make it into the kernel tree.
>
>Good luck,
>
>greg k-h
>
