Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932517AbVJCSfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbVJCSfO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 14:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbVJCSfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 14:35:14 -0400
Received: from usbb-lacimss3.unisys.com ([192.63.108.53]:15110 "EHLO
	usbb-lacimss3.unisys.com") by vger.kernel.org with ESMTP
	id S932517AbVJCSfM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 14:35:12 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 1/1] ES7000 platform update (i386)
Date: Mon, 3 Oct 2005 13:34:54 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04D83@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 1/1] ES7000 platform update (i386)
Thread-Index: AcXISMUn52BMsfKPT5mq87WosBgiUQAAC3kw
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Zwane Mwaikambo" <zwane@arm.linux.org.uk>
Cc: <akpm@osdl.org>, <ak@suse.de>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 03 Oct 2005 18:34:55.0299 (UTC) FILETIME=[26705130:01C5C849]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Zwane Mwaikambo [mailto:zwane@arm.linux.org.uk] 
> Sent: Monday, October 03, 2005 12:38 PM
> To: Protasevich, Natalie
> Cc: akpm@osdl.org; ak@suse.de; linux-kernel@vger.kernel.org
> Subject: Re: [patch 1/1] ES7000 platform update (i386)
> 
> Hello Natalie,
> 
> On Sun, 2 Oct 2005 Natalie.Protasevich@unisys.com wrote:
> 
> > @@ -62,6 +62,9 @@ static unsigned int base;  static int  
> > es7000_rename_gsi(int ioapic, int gsi)  {
> > +	if (es7000_plat == 2)
> > +		return gsi;
> 
> Could you #define that number to something so you can 
> immediately tell its Rascal/Zorro?
> 
> Thanks,
> 	Zwane
> 

Sure, good idea :) I will do that.
Thanks,
--Natalie
