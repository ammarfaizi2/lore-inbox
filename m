Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266884AbUBEW2B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 17:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266894AbUBEW2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 17:28:01 -0500
Received: from fmr09.intel.com ([192.52.57.35]:41638 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S266884AbUBEW1z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 17:27:55 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [Infiniband-general] Getting an Infiniband access layer in theLinux kernel
Date: Thu, 5 Feb 2004 14:26:46 -0800
Message-ID: <C1B7430B33A4B14F80D29B5126C5E94703262589@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Infiniband-general] Getting an Infiniband access layer in theLinux kernel
Thread-Index: AcPsMxphEQMKMmftR6GsZzH4qeaXoQAABmWwAACUPAA=
From: "Hefty, Sean" <sean.hefty@intel.com>
To: "Tillier, Fabian" <ftillier@infiniconsys.com>,
       "Chris Friesen" <cfriesen@nortelnetworks.com>,
       "Greg KH" <greg@kroah.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, <linux-kernel@vger.kernel.org>,
       <hozer@hozed.org>, "Woodruff, Robert J" <woody@co.intel.com>,
       "Magro, Bill" <bill.magro@intel.com>, <woody@jf.intel.com>,
       <infiniband-general@lists.sourceforge.net>
X-OriginalArrivalTime: 05 Feb 2004 22:26:46.0739 (UTC) FILETIME=[23F91A30:01C3EC37]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Personally, I'm amazed that professional developers have to discuss or
defend modular, portable code.

Once the code has been submitted, then specific implementation problems
can be dealt with.

- Sean


-----Original Message-----
From: Tillier, Fabian [mailto:ftillier@infiniconsys.com] 
Sent: Thursday, February 05, 2004 2:03 PM
To: Chris Friesen; Greg KH
Cc: Randy.Dunlap; Hefty, Sean; linux-kernel@vger.kernel.org;
hozer@hozed.org; Woodruff, Robert J; Magro, Bill; woody@jf.intel.com;
infiniband-general@lists.sourceforge.net
Subject: RE: [Infiniband-general] Getting an Infiniband access layer in
theLinux kernel

That is absolutely correct.  In addition to portability between kernel
versions and operating systems, there is also portability between
user-mode and kernel-mode within a single release.

- Fab

-----Original Message-----
From: Chris Friesen [mailto:cfriesen@nortelnetworks.com] 
Sent: Thursday, February 05, 2004 1:57 PM
To: Greg KH
Cc: Tillier, Fabian; Randy.Dunlap; sean.hefty@intel.com;
linux-kernel@vger.kernel.org; hozer@hozed.org; woody@co.intel.com;
bill.magro@intel.com; woody@jf.intel.com;
infiniband-general@lists.sourceforge.net
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in
theLinux kernel

Greg KH wrote:

> Basically, what is lacking in the current kernel locks that the
> infiniband project has to have in order to work properly.  We can work
> from there.

I think their point is that they want the core device driver code to be 
portable across kernel versions, and across different OS's other than 
linux--which basically requires some kind of abstraction layer.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

