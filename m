Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263169AbTCWT5W>; Sun, 23 Mar 2003 14:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263170AbTCWT5W>; Sun, 23 Mar 2003 14:57:22 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3593 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263169AbTCWT5V>; Sun, 23 Mar 2003 14:57:21 -0500
Date: Sun, 23 Mar 2003 20:08:20 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Martin Mares <mj@ucw.cz>
Cc: Robert Love <rml@tech9.net>, Alan Cox <alan@redhat.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Stephan von Krawczynski <skraw@ithnet.com>, Pavel Machek <pavel@ucw.cz>,
       szepe@pinerecords.com, arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Ptrace hole / Linux 2.2.25
Message-ID: <20030323200820.A20767@flint.arm.linux.org.uk>
Mail-Followup-To: Martin Mares <mj@ucw.cz>, Robert Love <rml@tech9.net>,
	Alan Cox <alan@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
	Stephan von Krawczynski <skraw@ithnet.com>,
	Pavel Machek <pavel@ucw.cz>, szepe@pinerecords.com,
	arjanv@redhat.com, linux-kernel@vger.kernel.org
References: <20030323193457.GA14750@atrey.karlin.mff.cuni.cz> <200303231938.h2NJcAq14927@devserv.devel.redhat.com> <20030323194423.GC14750@atrey.karlin.mff.cuni.cz> <1048448838.1486.12.camel@phantasy.awol.org> <20030323195606.GA15904@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030323195606.GA15904@atrey.karlin.mff.cuni.cz>; from mj@ucw.cz on Sun, Mar 23, 2003 at 08:56:06PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 23, 2003 at 08:56:06PM +0100, Martin Mares wrote:
> > Yes, I suspect he does as do most people here.
> > 
> > If you do not use a vendor kernel then you assume the responsibility of
> > doing this stuff yourself.  If you do not want to worry about these
> > things, use a vendor kernel.
> 
> But if you assume this, what are the official releases for anyway?

It is the way Linux is heading - becoming less free.  Lock-in to
distribution vendors.  And soon you'll need to pay distributions
to (timely) get the fixes.

To give an instance, because I don't work for a distribution, I don't
have access to the security lists.  Yet, I'm the guy who produces the
ARM patches which the ARM community at large use.

This situation caused HP to shut down their public ARM boxen while I
worked on integrating the security fix into the ARM tree.  Unfortunately,
this could only happen _after_ the problem was publically announced,
which means some of HPs systems were vulnerable to attack for a few
days.

If you think Linux today is about something "free"...

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

