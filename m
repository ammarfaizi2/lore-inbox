Return-Path: <linux-kernel-owner+w=401wt.eu-S1030265AbWLUMbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbWLUMbQ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 07:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbWLUMbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 07:31:16 -0500
Received: from jupiter.oxsemi.com ([62.255.240.98]:57923 "EHLO
	jupiter.oxsemi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030265AbWLUMbP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 07:31:15 -0500
X-Greylist: delayed 2615 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Dec 2006 07:31:14 EST
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH 0/4] New firewire stack - updated patches
Date: Thu, 21 Dec 2006 11:47:12 -0000
Message-ID: <BB29C48515F7A84FA1892C01BA3139270146DA10@muttley.corp.oxsemi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 0/4] New firewire stack - updated patches
Thread-Index: AcckaLSOXD/lK3lCQ52DJpPt82BMrwAd9Sig
From: "Duncan Beadnell" <duncan.beadnell@oxsemi.com>
To: "Stefan Richter" <stefanr@s5r6.in-berlin.de>,
       =?iso-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
Cc: <linux1394-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Well... I don't think eth1394 was ever used much and it's 
> not something
> > I plan to port over.
> 
> It is used, even though it is not very robust because it is 
> not actively
> maintained (yet). If your stack will shape up to become a potential
> replacement of mainline's stack, I'm sure _someone_ will do the port.


eth1394 is more widely used than may be apparent.

IP over 1394 is the basis for a number of activities in the 1394 Trade Association including "IEEE1394 Bridged over Coaxial Cable" and "Isochronous IP over 1394". 

The IEEE1394 Bridged over Coaxial Cable work allows the connection of 1394 clusters in different rooms through the already installed coaxial cable and the specification work includes the definition of the transport of AV/C commands over IP. This work dovetails nicely with CEA-2027-B and the work being done by HANA.

http://www.1394ta.org/Press/2006Press/august/8.4.a.htm

The Isochronous IP over 1394 work is designed to leverage the inherent quality of service provided by 1394 with the ubiquitousness of IP and builds on IP over 1394.


The existence of eth1394 in Linux provides vendors not just with support for IP networking but may also provide a route into the new technology areas mentioned above.

I would urge that eth1394 be ported to any updated 1394 stack. It is a useful feature of Linux and it would be a shame to see it disappear.


best wishes,

Duncan

--

Duncan Beadnell                
Principal R&D Engineer         
______________________________________________________________________
Oxford Semiconductor Ltd,              Switchboard: +44 (0)1235 824900
25 Milton Park,                                Fax: +44 (0)1235 821141
Abingdon, Oxfordshire,                         Web:     www.oxsemi.com
OX14 4SH, UK. 

