Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263490AbTKFKko (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 05:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263496AbTKFKko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 05:40:44 -0500
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:20109 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263490AbTKFKkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 05:40:43 -0500
Date: Thu, 6 Nov 2003 11:40:40 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: Larry McVoy <lm@work.bitmover.com>, Tomas Szepe <szepe@pinerecords.com>,
       Chad Kitching <CKitching@powerlandcomputers.com>, tytso@mit.edu
Subject: Re: BK2CVS problem
Message-ID: <20031106104040.GB8800@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Larry McVoy <lm@work.bitmover.com>,
	Tomas Szepe <szepe@pinerecords.com>,
	Chad Kitching <CKitching@powerlandcomputers.com>, tytso@mit.edu
References: <18DFD6B776308241A200853F3F83D507169CBC@pl6w2kex.lan.powerlandcomputers.com> <20031105230350.GB12992@work.bitmover.com> <20031106005224.GA7105@louise.pinerecords.com> <20031105185713.U10197@schatzie.adilger.int> <20031106030125.GA27184@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031106030125.GA27184@work.bitmover.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Nov 2003, Larry McVoy wrote:

> > Granted that this was not a break in BK itself the event is still alarming.
> > It makes me wonder if there is some way we can start using GPG signatures
> > with BK itself so that you can get proof-positive that a CSET annotated
> > as from davem really is from the David Miller we know and trust.
> 
> I couldn't agree more, we've thought about this and have a design,
> but credit where credit is due, Ted T'so is the driving force behind
> this idea.  He and I have had long discussions about this and we have a
> plan to do exactly that in BK.  I've already told Linus that we can add
> that to BK, and will, in the free version, so that you can at least be
> assured that all the stuff in BK is either flagged trusted or untrusted.
> 
> We think that is an excellent idea, we want to do it, but we were waiting
> for some event to trigger it.  We've been berated publicaly for each
> and every change we've made to the free version of BK so now we wait
> for people to ask for changes and then we'll make them.  Just say the
> word and we'll code this up as soon as we can.

The words "web of trust" (signing GPG keys) come to mind. Most software
that is GnuPG signed is signed with very short keys with no signature,
and GPG options such as --always-trust would be harmful here.

The advantage which is a difficulty at the same time is that the trust
level of each BK tree will then be different, depending on the local key
ring, trust settings and all that. This should be documented, to avoid
confusion.
