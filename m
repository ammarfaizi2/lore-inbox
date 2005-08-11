Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbVHKWDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbVHKWDr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 18:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbVHKWDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 18:03:47 -0400
Received: from usbb-lacimss2.unisys.com ([192.63.108.52]:44306 "EHLO
	usbb-lacimss2.unisys.com") by vger.kernel.org with ESMTP
	id S932390AbVHKWDq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 18:03:46 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC][2.6.12.3] IRQ compression/sharing patch
Date: Thu, 11 Aug 2005 17:02:36 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04CB6@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC][2.6.12.3] IRQ compression/sharing patch
Thread-Index: AcWenHEm/tUaIPm7T4K0q2kpBEn98QAI7+Ng
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Zwane Mwaikambo" <zwane@arm.linux.org.uk>
Cc: "Andi Kleen" <ak@suse.de>, "Brown, Len" <len.brown@intel.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 Aug 2005 22:02:36.0856 (UTC) FILETIME=[62364380:01C59EC0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 10 Aug 2005, Protasevich, Natalie wrote:
> 
> > our systems we are just about to use up all 224 interrupts, but not 
> > quiet.
> > I have to mention that as far as I know Zwane is about to 
> release his 
> > vector sharing mechanism, he had it implemented and working 
> for i386 
> > (I tested it on ES7000 successfully, by itself and combined with 
> > compression patch too), and was planning implementing it 
> for x86_64. I 
> > am officially volunteering for testing it in its present state, for 
> > both
> > i386 and x86_64 (I can still do this on our systems by removing the 
> > IRQ compression code :), hope this will help Zwane and Andi 
> to release 
> > it as soon as possible.
> 
> I added some of the suggestions brought forward (dynamically 
> allocated IDTs, percpu IDT) last night, all that's left is 
> MSI, which does work right now, but gets all its vectors 
> allocated on the first irq handling domain. I should be done 
> soon, time permitting.

Zwane, please let me know when I can try it on ES7000, even work in
progress if you need it (see above about volunteering :)

Regards,
--Natalie 
 
