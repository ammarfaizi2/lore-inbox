Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbUDOStI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 14:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbUDOSqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 14:46:21 -0400
Received: from hqemgate00.nvidia.com ([216.228.112.144]:19731 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S261638AbUDOSnH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 14:43:07 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Subject: RE: IO-APIC on nforce2 [PATCH]
Date: Thu, 15 Apr 2004 11:33:44 -0700
Message-ID: <DCB9B7AA2CAB7F418919D7B59EE45BAF49FB9D@mail-sc-6-bk.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: IO-APIC on nforce2 [PATCH]
Thread-Index: AcQii1sMayI33UYYRC+gZ5wxybOFpQAi+3yA
From: "Allen Martin" <AMartin@nvidia.com>
To: <ross@datscreative.com.au>, "Len Brown" <len.brown@intel.com>,
       =?iso-8859-1?Q?Christian_Kr=F6ner?= 
	<christian.kroener@tu-harburg.de>,
       "Linux-Nforce-Bugs" <Linux-Nforce-Bugs@exchange.nvidia.com>
Cc: <linux-kernel@vger.kernel.org>, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> True it is a bios thing but I have yet to see an nforce2 MOBO 
> that is not 
> routed in this way. I am thinking it is internal to the 
> chipset. I have seen
> none route it into io-apic pin2.

It was a bug in our original nForce reference BIOS that we gave out to vendors.  Since then we fixed the reference BIOS, but since it was after products shipped, most of the motherboard vendors won't pick up the change unless they get complaints from customers.

We've fixed it for our reference BIOS for future products though.


-Allen
