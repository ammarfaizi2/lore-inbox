Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319327AbSHVLy3>; Thu, 22 Aug 2002 07:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319328AbSHVLy3>; Thu, 22 Aug 2002 07:54:29 -0400
Received: from [212.143.73.98] ([212.143.73.98]:35319 "EHLO
	hawk.exanet-il.co.il") by vger.kernel.org with ESMTP
	id <S319327AbSHVLy2> convert rfc822-to-8bit; Thu, 22 Aug 2002 07:54:28 -0400
content-class: urn:content-classes:message
Subject: RE: Hyperthreading
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Thu, 22 Aug 2002 14:58:33 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0
Message-ID: <4913AB320D31DC4798D6FEF5F557351F6B9994@hawk.exanet-il.co.il>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Hyperthreading
Thread-Index: AcJJQWsiZWlptd0SRHizvb32RWuW1gAmf03Q
From: "Nir Soffer" <nirs@exanet.com>
To: "Hugh Dickins" <hugh@veritas.com>, "James Bourne" <jbourne@mtroyal.ab.ca>
Cc: "Reed, Timothy A" <timothy.a.reed@lmco.com>,
       <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 21 Aug 2002, James Bourne wrote:
> > On Wed, 21 Aug 2002, Reed, Timothy A wrote:
> > > 
> > > Can anyone lead me to a good source of information on 
> what options should be
> > > in the kernel for hyperthreading??  I am still fighting with a
> > > sub-contractor over kernel options.
> > 
> > As long as you have a P4 and use the P4 support you will get
> > hyperthreading with 2.4.19 (CONFIG_MPENTIUM4=y).  2.4.18 
> you have to also 
> > turn it on with a lilo option of acpismp=force on the 
> kernel command line.
> 
> You do need CONFIG_SMP and a processor capable of HyperThreading,
> i.e. Pentium 4 XEON; but CONFIG_MPENTIUM4 is not necessary for HT,
> just appropriate to that processor in other ways.
> 
> Hugh

Grepping for MPENTIUM4 in the tree only shows up that it causes the
kernel to be compiled with -march=i686, much like M686 and  MPENTIUMIII.
Are there more subtle ways it affects the kernel that I missed? (in the
2.4.x tree)

Thanks,
Nir.

--
Nir Soffer -=- Software Engineer, Exanet Inc. -=-
"Father, why are all the children weeping? / They are merely crying son
 O, are they merely crying, father? / Yes, true weeping is yet to come"
        -- Nick Cave and the Bad Seeds, The Weeping Song
