Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263752AbUDWBYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbUDWBYY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 21:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264261AbUDWBYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 21:24:24 -0400
Received: from hqemgate00.nvidia.com ([216.228.112.144]:39696 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S263752AbUDWBYX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 21:24:23 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Subject: RE: IO-APIC on nforce2 [PATCH]
Date: Thu, 22 Apr 2004 18:23:34 -0700
Message-ID: <DCB9B7AA2CAB7F418919D7B59EE45BAF49FBD4@mail-sc-6-bk.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: IO-APIC on nforce2 [PATCH]
Thread-Index: AcQobPLpOC7syq6yQMSsQ8SM+tl3jQAZFWkg
From: "Allen Martin" <AMartin@nvidia.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       "Len Brown" <len.brown@intel.com>
Cc: "Jamie Lokier" <jamie@shareable.org>, <ross@datscreative.com.au>,
       =?iso-8859-1?Q?Christian_Kr=F6ner?= 
	<christian.kroener@tu-harburg.de>,
       "Linux-Nforce-Bugs" <Linux-Nforce-Bugs@exchange.nvidia.com>,
       <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Allen, is there a possibility to get a clarification from 
> Nvidia on that?  
> Specifically, assuming both an 8254 and an I/O APIC core are 
> integrated
> into the chip, whether OUT0 of the 8254 is unconditionally routed to
> INTIN0 of the I/O APIC or is it configurable somehow.

The 8254 PIT is hardwared to IRQ0 on all nForce chipsets, it can't be routed.

-Allen
