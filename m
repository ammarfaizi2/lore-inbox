Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267364AbSLRVw7>; Wed, 18 Dec 2002 16:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267365AbSLRVw6>; Wed, 18 Dec 2002 16:52:58 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:63960 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S267364AbSLRVw5> convert rfc822-to-8bit; Wed, 18 Dec 2002 16:52:57 -0500
content-class: urn:content-classes:message
Subject: RE: Freezing.. (was Re: Intel P6 vs P7 system call performance)
Date: Wed, 18 Dec 2002 14:00:43 -0800
Message-ID: <3014AAAC8E0930438FD38EBF6DCEB564419D59@fmsmsx407.fm.intel.com>
X-MS-Has-Attach: 
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MS-TNEF-Correlator: 
Thread-Topic: Freezing.. (was Re: Intel P6 vs P7 system call performance)
Thread-Index: AcKmtPXIa62cgBKnEdeNgwACpYxNEwAJclKA
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Linus Torvalds" <torvalds@transmeta.com>,
       "Dave Jones" <davej@codemonkey.org.uk>
Cc: "Horst von Brand" <vonbrand@inf.utfsm.cl>, <linux-kernel@vger.kernel.org>,
       "Alan Cox" <alan@redhat.com>, "Andrew Morton" <akpm@digeo.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
X-OriginalArrivalTime: 18 Dec 2002 22:00:46.0004 (UTC) FILETIME=[EAAF5740:01C2A6E0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW, in terms of validation, I think we might want to compare the results from LTP (http://ltp.sourceforge.net/), for example, by having it run on the two setups (sysenter/sysexit and int/iret). 

Jun

> -----Original Message-----
> From: Linus Torvalds [mailto:torvalds@transmeta.com]
> Sent: Wednesday, December 18, 2002 8:50 AM
> To: Dave Jones
> Cc: Horst von Brand; linux-kernel@vger.kernel.org; Alan Cox; Andrew Morton
> Subject: Freezing.. (was Re: Intel P6 vs P7 system call performance)
> 
> 
> 
> On Wed, 18 Dec 2002, Dave Jones wrote:
> > On Wed, Dec 18, 2002 at 10:40:24AM -0300, Horst von Brand wrote:
> >  > [Extremely interesting new syscall mechanism tread elided]
> >  >
> >  > What happened to "feature freeze"?
> >
> > *bites lip* it's fairly low impact *duck*.
> 
> However, it's a fair question.
> 
> I've been wondering how to formalize patch acceptance at code freeze, but
> it might be a good idea to start talking about some way to maybe put
> brakes on patches earlier, ie some kind of "required approval process".
> 
> I think the system call thing is very localized and thus not a big issue,
> but in general we do need to have something in place.
> 
> I just don't know what that "something" should be. Any ideas? I thought
> about the code freeze require buy-in from three of four people (me, Alan,
> Dave and Andrew come to mind) for a patch to go in, but that's probably
> too draconian for now. Or is it (maybe start with "needs approval by two"
> and switch it to three when going into code freeze)?
> 
> 			Linus
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
