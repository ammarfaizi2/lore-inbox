Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbVEVTDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVEVTDx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 15:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVEVTDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 15:03:53 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59662 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261437AbVEVTDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 15:03:49 -0400
Date: Sun, 22 May 2005 20:03:44 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: When we detect that a 16550 was in fact part of a NatSemi SuperIO chip
Message-ID: <20050522200344.B9854@flint.arm.linux.org.uk>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <200505220008.j4M08uE9025378@hera.kernel.org> <1116763033.19183.14.camel@localhost.localdomain> <Pine.LNX.4.58.0505220953300.2307@ppc970.osdl.org> <1116785646.6285.24.camel@laptopd505.fenrus.org> <20050522194438.A9854@flint.arm.linux.org.uk> <1116787877.6285.26.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1116787877.6285.26.camel@laptopd505.fenrus.org>; from arjan@infradead.org on Sun, May 22, 2005 at 08:51:17PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2005 at 08:51:17PM +0200, Arjan van de Ven wrote:
> On Sun, 2005-05-22 at 19:44 +0100, Russell King wrote:
> > On Sun, May 22, 2005 at 08:14:06PM +0200, Arjan van de Ven wrote:
> > > On Sun, 2005-05-22 at 09:59 -0700, Linus Torvalds wrote:
> > > > 
> > > > On Sun, 22 May 2005, David Woodhouse wrote:
> > > > > 
> > > > > Linus, please do not apply patches from me which have my personal
> > > > > information mangled or removed.
> > > > 
> > > > I've asked Russell not to do it, but the fact is, he's worried about legal 
> > > > issues, and while I've also tried to resolve those (by having the OSDL 
> > > > lawyer try to contact some lawyers in the UK), that hasn't been clarified 
> > > > yet.
> > > 
> > > there is a potential nasty interaction with the UK moral rights thing
> > > where an author can demand that his authorship claim remains intact...
> > > so if David objects to his authorship being mangled (and partially
> > > removed) he may have a strong legal position to do so.
> > 
> > Actually, that only depends on whether you decide that Signed-off-by:
> > reflects authorship.
> 
> 
> author David Woodhouse <dwmw2@org.rmk.(none)> Sat, 21 May 2005 15:52:23 +0100
> 
> that looks far more like an authorship statement and is also munged.

In which case we have a problem:

http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=12f49643bc44c428919b210148a930496827dd26

Therefore, I put forward that this thing which appears to be called
"author" does not reflect authorship, but who submitted it.

Alternatively, if you are right, we must not wrongfully claim people
"author" code in this way, and the above log entry needs fixing.
Since that's not possible, we must refuse patches from people who
aren't themselves the authors of the submitted code.  But how do we
positively know that in every case?

That's another very interesting problem you've just brought up with
public project systems.  And of course now that it's been identified
it needs addressing.  8(

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
