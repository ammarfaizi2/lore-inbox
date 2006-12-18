Return-Path: <linux-kernel-owner+w=401wt.eu-S1754472AbWLRTnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754472AbWLRTnD (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 14:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754474AbWLRTnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 14:43:02 -0500
Received: from smtp.osdl.org ([65.172.181.25]:39804 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754472AbWLRTnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 14:43:00 -0500
Date: Mon, 18 Dec 2006 11:42:47 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alexandre Oliva <aoliva@redhat.com>
cc: Ricardo Galli <gallir@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: GPL only modules
In-Reply-To: <orpsah6m3s.fsf@redhat.com>
Message-ID: <Pine.LNX.4.64.0612181134260.3479@woody.osdl.org>
References: <200612161927.13860.gallir@gmail.com> <Pine.LNX.4.64.0612161253390.3479@woody.osdl.org>
 <orwt4qaara.fsf@redhat.com> <Pine.LNX.4.64.0612170927110.3479@woody.osdl.org>
 <orpsah6m3s.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Dec 2006, Alexandre Oliva wrote:
> 
> So I guess you approve of the reformulation of LGPL as an additional
> permission on top of GPL, as in its draft at gplv3.fsf.org, right?

Yes. I think that part of the GPLv3 is a good idea.

That said, I think they are still pushing the "you don't have any rights 
unless we give you additional rights explicitly" angle a bit too hard.

The fact is, people DO have rights, regardless of what the license says. 
We have them when it comes to music, and we have them when it comes to 
software. Copyright law only gives _limited_ rights to copyright holders, 
and we should actually fight those rights being expanded, instead of 
trying to expand on them ourselves.

> > No, the sane way to think about it is that linking just creates an 
> > "aggregate" work.
> 
> That's your take on it.  It does make sense, but claiming it's *the*
> sane way to think about it is making the mistake you accused the FSF
> of making.

I did point that out at the end of the email you quote. I said it's not 
necessarily the only way to look at things. But I GUARANTEE you that it 
makes more sense than the "no rights" approach, and I GUARANTEE you that 
it makes more sense than thinking that "ld is magic, and makes a derived 
work" approach.

> In fact, it can't possibly be exempt by this paragraph in clause 2 of
> the GPL:
> 
>   In addition, mere aggregation of another work not based on the
>   Program with the Program (or with a work based on the Program) on a
>   volume of a storage or distribution medium does not bring the other
>   work under the scope of this License.

This is actually a red herring. The way the GPLv2 _defines_ "work" and 
"Program" is by derived "derived work". 

You're confused by _your_ interpretation of "work" and "Program". You 
think that "Program" means "binary", because that's you think normally.

But the GPLv2 actually defines that "Program" is just the "derivative work 
under copyright law".

Really. Go look. It's right there at the very top, in section 0.

In other words, in the GPL, "Program" does NOT mean "binary". Never has.

And in fact, it wouldn't make sense if it did, since you can use the GPL 
for other things than just programs (and people have).

So you _always_ get back to the question: what is "derivative"? And the 
GPLv2 doesn't actually even say anything about that, but EXPLICITLY says 
that it is left to copyright law.

			Linus
