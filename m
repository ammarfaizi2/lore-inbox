Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbVI3B25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbVI3B25 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 21:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbVI3B25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 21:28:57 -0400
Received: from mx2.palmsource.com ([12.7.175.14]:18835 "EHLO
	mx2.palmsource.com") by vger.kernel.org with ESMTP id S1751413AbVI3B24 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 21:28:56 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: I request inclusion of SAS Transport Layer and AIC-94xx into the kernel
Date: Thu, 29 Sep 2005 18:28:54 -0700
Message-ID: <DE88BDF02F4319469812588C7950A97E93128D@ussunex1.palmsource.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: I request inclusion of SAS Transport Layer and AIC-94xx into the kernel
Thread-Index: AcXFVzftkdpTKAOqQQ6FGX/OE66BTQAA09zQ
From: "Martin Fouts" <Martin.Fouts@palmsource.com>
To: "Linus Torvalds" <torvalds@osdl.org>, "Luben Tuikov" <ltuikov@yahoo.com>
Cc: "Arjan van de Ven" <arjan@infradead.org>,
       "Willy Tarreau" <willy@w.ods.org>,
       "SCSI Mailing List" <linux-scsi@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Luben Tuikov" <luben_tuikov@adaptec.com>,
       "Jeff Garzik" <jgarzik@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Warning: philosophical thread hijack ahead ;) 

> A scientific theory is an approximation of observed behaviour 
> WITH NO KNOWN HOLES.

This has nothing to do with the topic at hand, but it is a pet peeve of
mine.  Sorry for hijacking a thread.

The above is a good one sentence approximation of what a theory is in
science, but it's not correct.  The classic example, of course, is
quantum mechanics, which is a very good theory, and has the glaring
notorious hole of lacking an explanation for gravity.

> 
> Once there are known holes in the theory, it's not a 
> scientific theory. At best it's an approximation, but quite 
> possibly it's just plain wrong.
> 

Alas, the difference between theory and practice is much larger in
practice.  Most scientific theories have known holes in them.  Not
always as glaring as the lack of quantum gravity, but always present.

There are even well documented cases where the theory was not supported
by the observations, so the observations were, eventually, redone, only
to determine that they were done wrong in the first place; so it's not
even as simple as 'must agree with reality'.

Science, once you lift the lid is a very messy endevour.

> And that's my point. Specs are not only almost invariably 
> badly written, they also never actually match reality. 

Ooops.  I'm going to have to go back on topic here.  I think that a
large part of this debate over specs is due to looking at two different
aspects of specs.  I have often worked in a world where specs were very
accurate, and kept current with reality.  This is the world in which
specs are the basis for new things.  When it works, it works very well.

Most of us, though, are living in the world of finished devices.  The
problem in our world is that specs are allowed to bit-rot.  Architects,
when they care a lot about their work, maintain two sets of plans, the
'as designed' plans and the  'as built' plans.  We in the computer
industry, for a lot of reasons, tend not to maintain the 'as built'
plans.

> So don't talk about specs.

Unfortunately, even in our imperfect world of imperfect specs, we still
need them.  Rather than 'don't talk about specs', in the real world, we
have to deal with 'here's a spec, add a grain of salt'.  You don't get
interoperability without that, and you don't get code portability
without it either.

> 
> Talk about working code that is _readable_ and _works_.
> 

Once upon a time, we converted an (unnamed) fortune 500 company's C
compiler from vendor X to vendor Y.  As head of the OS team, I
volunteered our kernel as a test ap.  Eventually, we found a very
readable implementation of select that, unfortunately, was utterly
busted C code.  "luckily", the old compiler had a bug in it that caused
it to generate working code for the utterly busted C code.

Needless to say that reality and the spec differed in this case.

And we fixed reality to match the spec.

> There's an absolutely mindbogglingly huge difference between the two.
> 

Yes.  "Be pragmatic about specs" is very good advice.  "Ignore specs" is
a recipe for anarchy. ;)

We now return your thread to its regularly scheduled debate.

