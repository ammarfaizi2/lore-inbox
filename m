Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264649AbUESXh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264649AbUESXh3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 19:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264653AbUESXh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 19:37:29 -0400
Received: from mail1.fw-sj.sony.com ([160.33.82.68]:41639 "EHLO
	mail1.fw-sj.sony.com") by vger.kernel.org with ESMTP
	id S264649AbUESXhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 19:37:23 -0400
Message-ID: <40ABEFA2.40503@am.sony.com>
Date: Wed, 19 May 2004 16:37:06 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: Christoph Hellwig <hch@infradead.org>,
       Mark Gross <mgross@linux.jf.intel.com>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: ANNOUNCE: CE Linux Forum - Specification V1.0 draft
References: <40A90D00.7000005@am.sony.com> <20040517201910.A1932@infradead.org> <200405171342.49891.mgross@linux.intel.com> <20040518074854.A7348@infradead.org> <40ABB5E2.3040908@am.sony.com> <20040519220819.GA5698@thunk.org>
In-Reply-To: <20040519220819.GA5698@thunk.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:
> On Wed, May 19, 2004 at 12:30:42PM -0700, Tim Bird wrote:
> 
>>What on earth are you talking about?  CELF includes members who
>>sell things, but the specification specifically discounts any
>>claims of conformance.
> 
> Perhaps not, but it uses the language of conformance:
> 
> 	The key words MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD,
> 	SHOULD NOT, RECOMMENDED, MAY, and OPTIONAL in this document are to be
> 	interpreted as described in [RFC2119]. The term "CELF-conforming" is
> 	used to refer to technology, platforms, or systems that conform to the
> 	CELF specifications or standards contained in this document.

Ted,

I completely agree with everything you say here, and I want
to clarify and correct any misunderstandings.

The reason conformance language is used is because, well,
specs. use conformance language to indicate levels of interest.

The primary audience for the specification (as indicated in
the introduction) is CE member company developers - NOT
community kernel developers.

> And in section 3.8.3, it states:
> 
> 	The Linux kernel SHALL support a configuration to provide the
> 	following described timing API.
> 
> Oh, it SHALL provide such a API, shall it?  Says who?  Does the CELF
> really think to dictate to the kernel developers that they SHALL use a
> particular API?
Absolutely not.  Despite the conformance langauge, the specs
are intended to be quite mutable in the context of a dialog
with community kernel developers.  Please note that there are
hundreds of kernel developers at these CE companies who are
not involved with the community at all.  We're trying to bridge
that gap where possible.

> Language such as this can really rub people the wrong
> way, especially when they don't have the authority to make such
> demands on the kernel development community.
I can see how this would be interpreted so.  I'll look
for a way to make documents interchanged with the community
avoid the possibility of such an interpretation.

> Something a lot more informal, such as, "look we really could use the
> following facility".  Here's a suggested API; we're not wedded to it,
> but this is why we need the following functionality.  Currently, the
> rationale/justification is currently completely missing for section
> 3.8.2 for this feature.
Dang. This is a MAJOR oversight.  This is supposed to be there, and
is more important in the context of this discussion than the
Specifications section.

I'll fix this pronto.

As for the formality issue, I'll look for a way to word
communications with the community so that there is no
implication of inflexibility.

> We are just told that we MUST and SHALL
> provide this feature, for no good stated reason:
> 

In the mean time, some background rationale for this is contained
on the page:
http://tree.celinuxforum.org/pubwiki/moin.cgi/InstrumentationAPI
(This page is out of date, but it has some information to provide
context for the requirement.)

> I think the reason why some folks might suspect that consortia such as
> CELF might be bilking their members is because such a document might
> easily be construed by a pointed-haired-boss that CELF might actually
> have the authority to dictate demands to the Linux Kernel development
> community.
I hope we can avoid that.  You'll have to take my word for it, but
NO ONE of the member companies has ever been told that we have the
power to dictate demands to the Linux development community.
Quite the contrary.

We even have a few special members (Greg Ungerer and Karim Yaghmour)
who are community developers themselves, and who we hope
can vouch for our intentions (at least from what they've seen.)
We invited these guys to join us in part to keep us "honest" with
the community.

> Would it not be more honest to admit freely that each one of these
> wishlist items involve a negotiation process, and the ultimate API
> might be different --- in some cases perhaps more restricted, or in
> other cases, in collaboration with the kernel development community,
> it might be that a more powerful, more general API that solves several
> problems might be devised?
Yes, I freely admit that each of these wishlist items involves
a negotiation process.  As is always the case with Linux, if
we have features that no one else wants, and the kernel development
community has no interest in - then if we must have them we'll
maintain them ourselves.  Nothing new here.

Here's some honesty which I don't think you'll hear from
anyone else.  The lack of control is part of the
reason the forum exists.  For stuff that the community won't
accept (and there will be some), it's nice to have a centralized,
controllable entity which manages such things.  A Linux vendor
doesn't quite fit the bill here.

So you see, the existence of the forum is in part an ACKNOWLEDGEMENT
of our inability to dictate the direction of Linux.

Finally, we fully expect that collaboration with the community
will produce much better results than we could come up with
ourselves.

> In any case, having discussion in closed forums can very often be a
> waste of time, since the discussions will then have to be replicated
> in the open forums --- in the case of linux kernel, in LKML --- before
> the discussions will actually do any good.
Agreed.  However, there are legitimate business reasons for
conducting some activities in private.  Also, believe it or not, but
one reason we've historically been so quiet is to avoid bothering
LKML with issues before we've researched them out.  Perhaps we've
erred on the side of quietness, but it's very difficult to gauge
when to come to LKML with an issue.  You can get flamed for
being unprepared, as well as for being overprepared.  Since
we've been primarily working on 2.4, we've felt very sheepish
about entering the fray on LKML on specific issues.

> I suppose for less
> confident folks, they could view CELF as a practice forum, or perhaps
> it is a way of anonymizing requests from people who don't want to
> admit that they are using Linux, or who don't want to admit they need
> a particular request.  They should be aware, however, that anonymous
> requests often get less weight than specific requests that explain
> specifically why a particular feature is needed.
We didn't mean to omit the explanation for the timing api request.
It's not even a "request" to kernel.org.  We try not to do that.

> 
> And definitely, an approach which is more collegial and less
> dictorial, which doesn't explain why the kernel developers MUST and
> SHALL do is much more likely to succeed.  You catch few flies with
> vinegar.
> 
> Just a few friendly suggestions....

I deeply appreciate your taking the time to make them.
I will take measures to correct the problems you identified
and try to avoid making them again in the future.

Thanks,

=============================
Tim Bird
Architecture Group Co-Chair
CE Linux Forum
Senior Staff Engineer
Sony Electronics
E-mail: Tim.Bird@am.sony.com
=============================

