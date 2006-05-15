Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751607AbWEOTgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbWEOTgk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 15:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751601AbWEOTgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 15:36:40 -0400
Received: from owa.omneon.com ([12.36.122.13]:50247 "EHLO
	snv-exh1.omneon.local") by vger.kernel.org with ESMTP
	id S1751589AbWEOTgj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 15:36:39 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: sata_mv module fails to load properly with 3 Supermicro AOC-SAT2-MV8 cards
Date: Mon, 15 May 2006 12:36:38 -0700
Message-ID: <F0E8D0B1F8999D479196DA72521D954A8DA9FF@snv-exh1.omneon.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: sata_mv module fails to load properly with 3 Supermicro AOC-SAT2-MV8 cards
Thread-Index: AcZ3+Nr2MEhoo4ImQAC/24eJaC2NTQAXPRig
From: "Michael Robak" <mrobak@Omneon.com>
To: <sander@humilis.net>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your reply.  

It apears that having multiple bus speeds is not the cause of my issue.
I was able to get the sata_mv module initalization to hang even when I
had only 2 cards plugged into both of the 100 MHz slots.  This issue is
extremely difficult to diagnose.  Sometimes the sata_mv module will load
just fine and recognize 24 drives, others it will hang the system during
intalization, and others it will only fine 23 drives, but the
initalization completes.  

Any help would be appreciated,

-Mike



-----Original Message-----
From: Sander [mailto:sander@humilis.net] 
Sent: Monday, May 15, 2006 1:23 AM
To: Michael Robak
Cc: linux-kernel@vger.kernel.org
Subject: Re: sata_mv module fails to load properly with 3 Supermicro
AOC-SAT2-MV8 cards

Michael Robak wrote (ao):
> Problem:
>   sata_mv module fails to load properly with 3 Supermicro AOC-SAT2-MV8
>   cards

I've reported more or less the same to the current maintainer. The third
card fails to work properly. In my case it seems to be because the first
two PCI-X slots are 133MHz and the third is 100MHz (Tyan K8SE).

Does that fit your case?

	With kind regards, Sander

--
Humilis IT Services and Solutions
http://www.humilis.net
