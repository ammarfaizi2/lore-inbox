Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264208AbUESTa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264208AbUESTa0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 15:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264205AbUESTa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 15:30:26 -0400
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:33200 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S264208AbUESTaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 15:30:13 -0400
Message-ID: <40ABB5E2.3040908@am.sony.com>
Date: Wed, 19 May 2004 12:30:42 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Mark Gross <mgross@linux.jf.intel.com>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: ANNOUNCE: CE Linux Forum - Specification V1.0 draft
References: <40A90D00.7000005@am.sony.com> <20040517201910.A1932@infradead.org> <200405171342.49891.mgross@linux.intel.com> <20040518074854.A7348@infradead.org>
In-Reply-To: <20040518074854.A7348@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> CELinux doesn't help either job, it's just listing the implementation details
> of the broken patches of a bunch of companies with vested interest, barely
> mentioning the requirements they try to fullfill.
I disagree.  I won't argue that the specifications have their
weaknesses,  but the specifications do much more than just
describe implementations.  Most of them have normative
sections which describe pretty high-level requirements,
and aren't specific about the possible solutions at all.

Also, I think you've interpreted the linked implementations
incorrectly.

Some of the implementations referenced by the spec are just quick
hacks to demonstrate the problem.  The one you pick on below
falls in this category.  No one has proposed that this patch
(which obviously is a quick hack, is based on 2.4, and was
never submitted by anyone to LKML) is a solution for the problem.

I think the specification for this particular area is not unclear
at all.  The normative section says (in part):
"1. The Linux kernel SHOULD use preemptible waits during IDE driver
initialization, rather than busywaits."

The non-normative section of this spec. explains where this was
a problem in 2.4, and why it is desirable, from the standpoint of
bootup time reduction, to avoid these busywaits.

Further discussion following your post indicates this might not be
a problem in 2.6.  This is exactly the type of valuable feedback
CELF appreciates getting from the community, so I fail to see
how the spec., when considered as a communication vehicle, can
be considered "useless".

> 
> You'd make our life a lot easier by first writing down the requirement,
> the thinking of soultions instead of taking the one $MEMBERCOMPANY proposed,
> where that thinking shoould involve talking to the mailinglists for that
> area and finally proposing a patch describing _the requirement_, not what
> you've done.  CELinux, just like CGL or DCL has very much failed this
> procedure.
Evidence?  This is just a rant.  It sounds like you don't know
anything about our organization, or what we've done over the
past year.  Our requirements working group would be surprised
to find out that CELF didn't methodically gather requirements
from our members.  etc. etc.

> So far I can't see CElinux as anything but a useless specication tricking
> PHBs into buying a products of the member companies because they're following
> a specification (of which $PHB of course doesn't know how useless it is)

Christoph,

What on earth are you talking about?  CELF includes members who
sell things, but the specification specifically discounts any
claims of conformance.  The big members are people like Sony,
Panasonic, Samsung, etc. who are not selling anything to PHBs
(well, except TVs, settops, cellphones, etc, that we hope to
put Linux in.  :-)

Our goal is to improve Linux for use in our products.

> If patches aren't even discussed on lkml it means you've done something very
> wrong.  I don't really remember any of the patches you submitted on lkml.

We are interested in the Protected RAM File system, which was posted
by MontaVista.  We are also interested in high resolution timers,
which was posted by George Anzinger (also, of MontaVista).  There
was discussion on both of these, which we noted carefully.  We are
currently working on issues that were raised with regard to HRT,
in the hopes of improving its acceptability.

But my main point is that it's incorrect to assume that CELF
is doing nothing, just because things don't come from a CELF e-mail.
(The forum doesn't even provide e-mail accounts.)

> But let's take one of the patches, the first one I looked at on your wiki
> apart:
>...
[bad patch, and rant, removed]

> So if I can give you guys from the various industry consortia some hints:
> 
>  o think before you code
>  o don't drink and code
>  o get a clue

As stated above, this patch was not proposed to be a solution for
the problem mentioned in the spec.  I agree with you that the code
is quite embarassing.  If you see CELF actually submit code like
that to LKML, then please feel free to give us a smackdown.  ;-)

In the mean time, your posting of it generated some useful feedback
which is genuinely appreciated.

This last point actually gives me something to think about.
I have resisted sending patches like what you quoted, but
it generated useful comments very quickly.  Maybe we should
loosen up and let you see more of our half-baked work?
(But smacking us around doesn't really encourage that...)

Regards,

=============================
Tim Bird
Architecture Group Co-Chair
CE Linux Forum
Senior Staff Engineer
Sony Electronics
E-mail: Tim.Bird@am.sony.com
=============================

