Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262269AbVCHXqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbVCHXqZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 18:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262243AbVCHXhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 18:37:52 -0500
Received: from web52910.mail.yahoo.com ([206.190.39.187]:1917 "HELO
	web52910.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262227AbVCHXgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 18:36:31 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=RzMfRJWg2ZPu7rdwtxWnvPjqpEM53NMoMiipoZ8T1u5aKw257HphIbbcfAq+oD6EYt8ldM2Er6ZTRKU3MuMJRKA85l8wnY8TQQyWhQw+5D12NSpYBDdxoSj9Tt92kVpjoRknt2h8aKhry+y5dn5AVJSt0B9ZvWfgE39nKWe2clA=  ;
Message-ID: <20050308233619.69796.qmail@web52910.mail.yahoo.com>
Date: Wed, 9 Mar 2005 00:36:19 +0100 (CET)
From: szonyi calin <caszonyi@yahoo.com>
Subject: Re: RFD: Kernel release numbering
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Jeff Garzik <jgarzik@pobox.com> wrote:
> Greg KH wrote:
> > On Wed, Mar 02, 2005 at 05:15:36PM -0800, Linus Torvalds
> wrote:
> > 
> > 
> > But when pressed about the issue of speed of development,
> rate of
> > change, feature increase, driver updates, and so on, no one
> else has any
> > clue of what to do.  They respond with, "but only put
> bugfixes into a
> > stable release."  My comeback is explaining how we handle
> lots of
> > different types of bugfixes, by api changes, real fixes, and
> driver
> > updates for new hardware.  Sometimes these cause other bugs
> to happen,
> > or just get shaken out where they were previously hiding
> (acpi is a
> > great example of this issue.)  In the end, they usually fall
> back on
> > muttering, "well, I'm just glad that I'm not a kernel
> developer..." and
> > back away.
> 
> The pertinent question for a point release (2.6.X.Y) would
> simply be 
> "does a 2.6.11 user really need this fix?"
> 

no. If something is not working in 2.6.11 i will switch to 
2.6.10 ;-) and _maybe_ report  a bug

> 
> > Like I previously said, I think we're doing a great job. 
> The current
> > -mm staging area could use some more testers to help weed
> out the real
> > issues, and we could do "real" releases a bit faster than
> every 2 months
> > or so.  But other than that, we have adapted over the years
> to handle
> > this extremely high rate of change in a pretty sane manner.
> 
> I think Linus's "even/odd" proposal is an admission that 2.6.X
> releases 
> need some important fixes after it hits kernel.org.
> 
> Otherwise 2.6.X is simply a constantly indeterminent state.
> 

Let me tell you what i understood from this thread:
2.6.12 "almost stable"
2.6.13 devel (new drivers,fixes  and stuff -- may be broken)
2.6.14 (based on 2.6.13) tries to became stable again
2.6.15 also devel (see above)
2.6.16 (based on 2.6.15) also tries to became stable again

So we will _want_ to have a stable kernel (like 2.4 now) but 
this will never happen (see above) 

> We need to serve users, not just make life easier for kernel
> developers ;-)
> 

You said it. Hopefully you will make our life easier and we 
(as testers) will make your's.

> 	Jeff
> 



--
A mouse is a device used to point at 
the xterm you want to type in.
Kim Alm on a.s.r.


	

	
		
Découvrez le nouveau Yahoo! Mail : 250 Mo d'espace de stockage pour vos mails ! 
Créez votre Yahoo! Mail sur http://fr.mail.yahoo.com/
