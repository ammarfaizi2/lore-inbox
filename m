Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266918AbUBEWCe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 17:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266921AbUBEWCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 17:02:33 -0500
Received: from gw0.infiniconsys.com ([65.219.193.226]:24860 "EHLO
	mail.infiniconsys.com") by vger.kernel.org with ESMTP
	id S266918AbUBEWCb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 17:02:31 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Infiniband-general] Getting an Infiniband access layer in theLinux kernel
Date: Thu, 5 Feb 2004 17:02:30 -0500
Message-ID: <08628CA53C6CBA4ABAFB9E808A5214CB01DB96F2@mercury.infiniconsys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Infiniband-general] Getting an Infiniband access layer in theLinux kernel
Thread-Index: AcPsMxphEQMKMmftR6GsZzH4qeaXoQAABmWw
From: "Tillier, Fabian" <ftillier@infiniconsys.com>
To: "Chris Friesen" <cfriesen@nortelnetworks.com>, "Greg KH" <greg@kroah.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, <sean.hefty@intel.com>,
       <linux-kernel@vger.kernel.org>, <hozer@hozed.org>, <woody@co.intel.com>,
       <bill.magro@intel.com>, <woody@jf.intel.com>,
       <infiniband-general@lists.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

