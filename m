Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262586AbREVQYy>; Tue, 22 May 2001 12:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262581AbREVQYp>; Tue, 22 May 2001 12:24:45 -0400
Received: from alpo.casc.com ([152.148.10.6]:38612 "EHLO alpo.casc.com")
	by vger.kernel.org with ESMTP id <S262586AbREVQYd>;
	Tue, 22 May 2001 12:24:33 -0400
From: John Stoffel <stoffel@casc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15114.37415.204391.420484@gargle.gargle.HOWL>
Date: Tue, 22 May 2001 12:21:59 -0400
To: David Woodhouse <dwmw2@infradead.org>
Cc: John Stoffel <stoffel@casc.com>, linux-kernel@vger.kernel.org
Subject: Re: Background to the argument about CML2 design philosophy 
In-Reply-To: <7938.990539153@redhat.com>
In-Reply-To: <15113.31946.548249.53012@gargle.gargle.HOWL>
	<20010520165952.A9622@devserv.devel.redhat.com>
	<20010518113726.A29617@devserv.devel.redhat.com>
	<20010518114922.C14309@thyrsus.com>
	<8485.990357599@redhat.com>
	<20010520111856.C3431@thyrsus.com>
	<15823.990372866@redhat.com>
	<20010520114411.A3600@thyrsus.com>
	<16267.990374170@redhat.com>
	<20010520131457.A3769@thyrsus.com>
	<18686.990380851@redhat.com>
	<20010520164700.H4488@thyrsus.com>
	<25499.990399116@redhat.com>
	<7938.990539153@redhat.com>
X-Mailer: VM 6.91 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David> You appear to be responding to my email, yet you did not do me
David> the courtesy of including me in the recipients. Should I assume
David> you're asking this question of me directly, or was it a
David> rhetorical question?

It was more of an attempt to cutdown on the number of recipients, not
any attempt to keep you out of the discussion.  This time, I've left
the recipients alone.

David> Good. You should be prevented from creating a .config which is
David> broken, and the existing CML1 rules attempt to achieve
David> this. 

We are in agreement here, though I doubt that the CML1 ruleset really
achieves this goal in any serious way.  It just doesn't have the power.

David> CML2 should continue to do so, and indeed should do so more
David> effectively and flexibly.

Agreed.

David> What I fear is that such new, unwanted, dependencies may be
David> introduced to the kernel -- either by accident or by deception
David> -- in the large patch which introduces CML2 and converts the
David> existing rules files. Subtle changes to the behaviour could
David> easily go unnoticed in such a large patch.

I don't agree with this, since the current CML1 scheme has wierd,
unwanted and wrong dependencies already, which can't (or haven't) been
found.   Since it would be put in during the 2.5.x branching, it's
expected that things will/can/should break, so I don't think there
will be any dire consequences.  

David> I think you are being overly defensive. I was not saying that
David> CML2 is wrong. I said that I was ambivalent about CML2, and the
David> point I'm talking about is entirely irrelevant to CML2 - except
David> that I'm trying to make sure that the large CML2 patch is not
David> used as a vehicle for sneaking other, more contentious, changes
David> into the kernel.

Such as what?  Do you have any examples here?  

David> I want to discuss those changes _separately_ once the CML2
David> issue is out of the way, because otherwise people just won't
David> bother to read what I said, and will assume I'm arguing against
David> CML2 itself.

This is the first time you have come out and explicitly *said* what
you are for and against in CML2.  People need to be clear about what
they are talking about.

As a general question for all readers, how many are against CML2 in
any shape or form?

How many are like David, and don't mind CML2, but are worried about
dependency issues?

How many think CML2 and it's dependencies will be a step forward in
kernel configuration?

Thanks,
John
