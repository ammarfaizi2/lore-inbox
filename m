Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262857AbTHUR4w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 13:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbTHUR4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 13:56:52 -0400
Received: from fmr09.intel.com ([192.52.57.35]:12283 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S262857AbTHUR4u convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 13:56:50 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: 2.6.0-test3 smp irq balance
Date: Thu, 21 Aug 2003 10:56:47 -0700
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1902C7D1DE@fmsmsx405.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.0-test3 smp irq balance
Thread-Index: AcNoBeVQWgCwuoBNQiGTfct1NIPOZwAB4sfw
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Jens Gecius" <jens@gecius.de>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Aug 2003 17:56:48.0509 (UTC) FILETIME=[97AD5AD0:01C3680D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This lkml thread may be of help.
http://www.ussg.iu.edu/hypermail/linux/kernel/0301.3/0197.html

-Venkatesh

> -----Original Message-----
> From: Jens Gecius [mailto:jens@gecius.de] 
> Sent: Thursday, August 21, 2003 9:22 AM
> To: linux-kernel@vger.kernel.org
> Subject: Re: 2.6.0-test3 smp irq balance
> 
> 
> Arjan van de Ven <arjanv@redhat.com> writes:
> 
> >> irqs seem not to be distributed between cpus, having one 
> to handle all
> >> (even while building kernel on both cpus (according to gkrell), the
> >> numbers for the second cpu don't change.
> >
> > just install and run the irqbalance daemon from:
> > http://people.redhat.com/arjanv/irqbalance
> 
> I did. Didn't change anything. The numbers are the same - the only
> CPU2 irq increasing is LOC. Any other hints?
> 
> -- 
> Tschoe,                http://gecius.de/gpg-key.txt - Fingerprint:
>  Jens                  1AAB 67A2 1068 77CA 6B0A  41A4 18D4 
> A89B 28D0 F097
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
