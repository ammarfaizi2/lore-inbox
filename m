Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265636AbSKFEJb>; Tue, 5 Nov 2002 23:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265637AbSKFEJb>; Tue, 5 Nov 2002 23:09:31 -0500
Received: from tisch.mail.mindspring.net ([207.69.200.157]:56594 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S265636AbSKFEJa>; Tue, 5 Nov 2002 23:09:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Mike Diehl <mdiehl@dominion.dyndns.org>
To: kcorry@austin.rr.com, evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] EVMS announcement
Date: Tue, 5 Nov 2002 20:45:58 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
References: <02110516191004.07074@boiler> <20021105215100.E927E51CF@dominion.dyndns.org> <02110518360200.00235@cygnus>
In-Reply-To: <02110518360200.00235@cygnus>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20021106022549.C849B55A9@dominion.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 November 2002 07:36 pm, Kevin Corry wrote:
     > Hi Mike,

I don't know if you remember me, but you bailed me out from some trouble I 
had with LVM.... TWICE!


     > I'm sorry you feel disappointed. But I assure you that EVMS will
     > continue to provide the same experience you have come to expect. All
     > this decision really means is that we will be building on a different
     > kernel component, instead of providing our own. All of the EVMS tools
     > and libraries will essentially be unchanged from the perspective of
     > most users.

I've had some time to think about this.  As a programmer, I am lothe to 
re-invent any wheel that someone else already has.  I think this may be how 
you guys came to this decision.

     > And we will still maintain that modular design. In fact, we see this
     > as making the design even more modular, since it won't have to be tied
     > to a single kernel driver. Device mapper can be used for supporting
     > disk partitions, LVM, and some other plugins. The MD driver can be
     > used to support software RAID. We've even had thoughts about building
     > on the existing loop driver in order to provide the partition-level
     > encryption that you mentioned. And all of this from a single, unified
     > interface.

It's beginning to sound like you may be able to leverage the work that went 
into MD and LVM and consentrate on (perhapse) some really cool stuff, like 
partition-level encyption, or the disk partitioning scheme involving RAID, 
NBD's and LVM that Alan Cox outlined in another post.

     > > But never mind me.  I'm just a linux user, not a linux developer.
     >
     > Actually, it *is* the users that we are most concerned with. This is
     > why we are going to make such an effort to keep our tools as unchanged
     > as possible. But we really do think that this is the best solution in
     > the long term, for both the users and the developers.

As I said in a different post, that was a cheep shot on my part.  I'm usually 
much bigger than that.  

So, let me try to understand.  The EVMS team is going to rip out the guts of 
their user-land utils in order to comply with the existing (mainstream) API, 
and abandon their own API.  This should reduce the amount of code actually in 
the kernel.  (ignoring the user-land v. kernel-level discovery debate)

Na, I can't ignore the debate.  I can't wait to see how user-land descovery 
will be implemented.  There is something intrinsically "nice" about having an 
OS automatically discover every aspect of a machine I'm installing on.  I 
guess it's going to fall to the Linux distributors to package this system 
well.  If they don't, first-time Mandrake or RH installers will be doomed to 
that (shudder) other operating system.

     > If you continue to have any concerns about this, please let us know.
     > We will do our best to address them and explain any other details
     > about this change that you are unsure of.

I'll just have to wait.  BTW, Kevin, if you are ever in Albuquerque, NM.  let 
me know; I still owe you a beer. <grin>

-- 
Mike Diehl
PGP Encrypted E-mail preferred.
Public Key via: http://dominion.dyndns.org/~mdiehl/mdiehl.asc

