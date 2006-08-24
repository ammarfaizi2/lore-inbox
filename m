Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030196AbWHXQWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbWHXQWH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 12:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030373AbWHXQWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 12:22:07 -0400
Received: from zcars04f.nortel.com ([47.129.242.57]:44020 "EHLO
	zcars04f.nortel.com") by vger.kernel.org with ESMTP
	id S1030196AbWHXQWE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 12:22:04 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Areca arcmsr kernel integration for 2.6.18?
Date: Thu, 24 Aug 2006 12:21:01 -0400
Message-ID: <25E284CCA9C9A14B89515B116139A94D0D353411@zrtphxm0.corp.nortel.com>
In-Reply-To: <1156419687.3007.98.camel@localhost.localdomain>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Areca arcmsr kernel integration for 2.6.18?
Thread-Index: AcbHb1NY8ea1qixiTTa/95olxDwmYgAJhYXQ
From: "Theodore Bullock" <tbullock@nortel.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Arjan van de Ven" <arjan@infradead.org>
Cc: "Dax Kelson" <dax@gurulabs.com>, "Greg KH" <gregkh@suse.de>,
       "James Bottomley" <James.Bottomley@SteelEye.com>,
       "Andrew Morton" <akpm@osdl.org>, <robm@fastmail.fm>,
       <brong@fastmail.fm>, <erich@areca.com.tw>, <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I posted a feature enchancement request to the Novell bugzilla for the
10.2 openSUSE release (currently scheduled for 2.6.18 AFAIK, depends on
upstream timelines), and the response from Greg was this:

"If this driver is in the mainline kernel, it will show up in our
releases, and that's the only way we can accept it at this point in
time.  We will not backport it to an older kernel version."

If the driver goes into 2.6.19 this means 8 to 12 months of time before
our workstations will be supported enough by Novell to start a more
widespread deployment in the company out of the test lab.  We would
prefer this driver to be made available earlier, if only to make
installation more feasible and kernel upgrades possible.

-Ted Bullock
Nortel Networks

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
Sent: August 24, 2006 5:41 AM
To: Arjan van de Ven
Cc: Dax Kelson; Greg KH; James Bottomley; Andrew Morton; Bullock,
Theodore (WIC:2J00); robm@fastmail.fm; brong@fastmail.fm;
erich@areca.com.tw; greg@kroah.com; linux-kernel@vger.kernel.org
Subject: Re: Areca arcmsr kernel integration for 2.6.18?

Ar Iau, 2006-08-24 am 10:34 +0200, ysgrifennodd Arjan van de Ven:
> > The current Fedora Core 6 development (and consequently RHEL5 and
> > CentOS5) is using 2.6.18-rc kernels (actually as of yesterday, your 
> > git tree).
> 
> .. and those distros can't pull in this driver because..... ?

FC6 policy is to follow upstream very closely. RHEL may vary.

I don't think its fair to ask Greg to make this decision and James has
already given a clear answer.

Alan

