Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315455AbSHMNiF>; Tue, 13 Aug 2002 09:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315483AbSHMNiF>; Tue, 13 Aug 2002 09:38:05 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:30936 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S315455AbSHMNiD>; Tue, 13 Aug 2002 09:38:03 -0400
Message-Id: <200208131340.g7DDeEb207512@pimout2-ext.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Daniel Phillips <phillips@arcor.de>, Larry McVoy <lm@bitmover.com>,
       Rik van Riel <riel@conectiva.com.br>
Subject: Re: large page patch (fwd) (fwd)
Date: Tue, 13 Aug 2002 04:40:08 -0400
X-Mailer: KMail [version 1.3.1]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, frankeh@watson.ibm.com,
       davidm@hpl.hp.com, David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>, gh@us.ibm.com,
       Martin.Bligh@us.ibm.com, William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
References: <1029113179.16236.101.camel@irongate.swansea.linux.org.uk> <20020811165003.F17310@work.bitmover.com> <E17eAT4-0001n3-00@starship>
In-Reply-To: <E17eAT4-0001n3-00@starship>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 August 2002 04:22 am, Daniel Phillips wrote:

> Yes.  I would like to add my current rmap optimization work, if it is
> worthy for the usual reasons, to the kernel under a DPL license which is in
> every respect the GPL, except that it adds one additional restriction along
> the lines:
>
>   "If you enforce a patent against a user of this code, or you have a
>    beneficial relationship with someone who does, then your licence to
>    use or distribute this code is automatically terminated"
>
> with more language to extend the protection to the aggregate work, and to
> specify that we are talking about enforcement of patents concerned with any
> part of the aggregate work.  Would something like that fly?
>
> In other words, use copyright law as a lever against patent law.

More than that, the GPL could easily be used to form a "patent pool".  Just 
say "This patent is licensed for use in GPL code.  If you want to use it 
outside of GPL code, you need a seperate license."

The purpose of modern patents is Mutually Assured Destruction: If you sue me, 
I have 800 random patents you're bound to have infringed just by breating, 
and even though they won't actually hold up to scrutiny I can keep you tied 
up in court for years and force you to spend millions on legal fees.  So why 
don't you just cross-license your entire patent portfolio with us, and that 
way we can make the whole #*%(&#% patent issue just go away.  (Notice: when 
aybody DOES sue, the result is usually a cross-licensing agreement of the 
entire patent portfolio.  Even in those rare cases when the patent 
infringement is LEGITIMATE, the patent system is too screwed up to function 
against large corporations due to the zillions of frivolous patents and the 
tendency for corporations to have lawyers on staff so defending a lawsuit 
doesn't really cost them anything.)

This is how companies like IBM and even Microsoft think.  They get as many 
patents as possible to prevent anybody ELSE from suing them, because the 
patent office is stupid enough to give out a patent on scrollbars a decade 
after the fact and they don't want to be on the receiving end of this 
nonsense.  And then they blanket cross-license with EVERYBODY, so nobody can 
sue them.

People do NOT want to give a blanket license to everybody for any use on 
these patents because it gives up the one thing they're good for: mutually 
assured destruction.  Licensing for "open source licenses" could mean "BSD 
license but we never gave anybody any source code, so ha ha."

But if people with patents were to license all their patents FOR USE IN GPL 
CODE, then any proprietary infringement (or attempt to sue) still gives them 
leverage for a counter-suit.  (IBM retained counter-suit ability in a 
different way: you sue, the license terminates.  That's not bad, but I think 
sucking the patent system into the GPL the same way copyright gets inverted 
would be more useful.)

This is more or less what Red Hat's done with its patents, by the way.  
Blanket license for use under GPL-type licenses, but not BSD because that 
would disarm mutually assured destruction.  Now if we got somebody like IBM 
on board a GPL patent pool (with more patents than anybody else, as far as I 
know), that would realy mean something...

Unfortunately, the maintainer of the GPL is Stallman, so he's the logical guy 
to spearhead a "GPL patent pool" project, but any time anybody mentions the 
phrase "intellectual property" to him he goes off on a tangent about how you 
shouldn't call anything "intellectual property", so how can you have a 
discussion about it, and nothing ever gets done.  It's FRUSTRATING to see 
somebody with such brilliant ideas hamstrung not just by idealism, but 
PEDANTIC idealism.

Sigh...

Rob
