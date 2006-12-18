Return-Path: <linux-kernel-owner+w=401wt.eu-S1754556AbWLRUhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754556AbWLRUhm (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 15:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754558AbWLRUhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 15:37:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32990 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754556AbWLRUhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 15:37:41 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ricardo Galli <gallir@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: GPL only modules
References: <200612161927.13860.gallir@gmail.com>
	<Pine.LNX.4.64.0612161253390.3479@woody.osdl.org>
	<orwt4qaara.fsf@redhat.com>
	<Pine.LNX.4.64.0612170927110.3479@woody.osdl.org>
	<orpsah6m3s.fsf@redhat.com>
	<Pine.LNX.4.64.0612181134260.3479@woody.osdl.org>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat OS Tools Group
Date: Mon, 18 Dec 2006 18:37:31 -0200
In-Reply-To: <Pine.LNX.4.64.0612181134260.3479@woody.osdl.org> (Linus Torvalds's message of "Mon\, 18 Dec 2006 11\:42\:47 -0800 \(PST\)")
Message-ID: <or64c96ius.fsf@redhat.com>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 18, 2006, Linus Torvalds <torvalds@osdl.org> wrote:

> That said, I think they are still pushing the "you don't have any rights 
> unless we give you additional rights explicitly" angle a bit too hard.

Maybe it's just a matter of perception.  I don't see it that way from
the inside.

How about
http://gplv3.fsf.org/comments/rt/readsay.html?filename=gplv3-draft-2&id=2238

Would it help address your mis-perception?

> But I GUARANTEE you that it makes more sense than the "no rights"
> approach

Yeah, but that's a Straw Man.

> and I GUARANTEE you that it makes more sense than thinking that "ld
> is magic, and makes a derived work" approach.

I believe you and I have already shot down the 'ld-is-like-mkisofs'
argument.

>> In fact, it can't possibly be exempt by this paragraph in clause 2 of
>> the GPL:

>> In addition, mere aggregation of another work not based on the
>> Program with the Program (or with a work based on the Program) on a
>> volume of a storage or distribution medium does not bring the other
>> work under the scope of this License.

> This is actually a red herring. The way the GPLv2 _defines_ "work" and 
> "Program" is by derived "derived work". 

No, that's how it defines 'work based on the Program', see the quoted
portion below.

> You're confused by _your_ interpretation of "work" and "Program". You 
> think that "Program" means "binary", because that's you think normally.

I can't see where you drew that conclusion from, but it's an incorrect
conclusion.  Program can denote the sources as much as the binaries.

> But the GPLv2 actually defines that "Program" is just the "derivative work 
> under copyright law".

> Really. Go look. It's right there at the very top, in section 0.

/me looks again

  0. This License applies to any program or other work which contains
a notice placed by the copyright holder saying it may be distributed
under the terms of this General Public License.  The "Program", below,
refers to any such program or work, and a "work based on the Program"
means either the Program or any derivative work under copyright law:
that is to say, a work containing the Program or a portion of it,
either verbatim or with modifications and/or translated into another
language.  (Hereinafter, translation is included without limitation in
the term "modification".)

> In other words, in the GPL, "Program" does NOT mean "binary". Never has.

Agreed.  So what?  How does this relate with the point above?

The binary is a Program, as much as the sources are a Program.  Both
forms are subject to copyright law and to the license, in spite of
http://www.fsfla.org/?q=en/node/128#1

> And in fact, it wouldn't make sense if it did, since you can use the GPL 
> for other things than just programs (and people have).

People do many odd things.  How do you define source code and object
code to other things that are not programs.

> So you _always_ get back to the question: what is "derivative"? And the 
> GPLv2 doesn't actually even say anything about that, but EXPLICITLY says 
> that it is left to copyright law.

Exactly.  No disagreement here.

I'm not disputing this fact.

In the point you quoted above, I was only disputing your argument of
"mere aggregation" in the context of dynamic linking.

-- 
Alexandre Oliva         http://www.lsd.ic.unicamp.br/~oliva/
FSF Latin America Board Member         http://www.fsfla.org/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
