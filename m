Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263607AbUECII4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263607AbUECII4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 04:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263609AbUECII4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 04:08:56 -0400
Received: from hqemgate02.nvidia.com ([216.228.112.145]:39949 "EHLO
	hqemgate02.nvidia.com") by vger.kernel.org with ESMTP
	id S263607AbUECIIy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 04:08:54 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Subject: RE: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH] for idle=C1halt, 2.6.5
Date: Mon, 3 May 2004 01:08:06 -0700
Message-ID: <DCB9B7AA2CAB7F418919D7B59EE45BAF49FC23@mail-sc-6-bk.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH] for idle=C1halt, 2.6.5
Thread-Index: AcQtFBWLdjoxNbHDQyacT1OOH8SaMQD0M9Aw
From: "Allen Martin" <AMartin@nvidia.com>
To: <ross@datscreative.com.au>, "Len Brown" <len.brown@intel.com>,
       <a.verweij@student.tudelft.nl>
Cc: "Jesse Allen" <the3dfxdude@hotmail.com>,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       "Craig Bradney" <cbradney@zip.com.au>,
       <christian.kroener@tu-harburg.de>, <linux-kernel@vger.kernel.org>,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       "Jamie Lokier" <jamie@shareable.org>,
       "Daniel Drake" <dan@reactivated.net>, "Ian Kumlien" <pomac@vapor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> I also recollect that Windows had lockups with nforce2 for a while
> depending
> whether you ran the Nvidia or Microsoft driver.
> http://lkml.org/lkml/2003/12/13/5
> Anybody got the inside running on that one and what was different
between
> the
> two drivers?


There were some ATAPI device detection problems in some of the earlier
Windows nForce IDE drivers that would cause lockups during boot for some
people depending on what type of devices were attached.  

There's never been any reports of Windows hangs that have been root
caused to C1 disconnects that I'm aware of.

-Allen
