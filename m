Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266907AbSLDEuU>; Tue, 3 Dec 2002 23:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266908AbSLDEuU>; Tue, 3 Dec 2002 23:50:20 -0500
Received: from dp.samba.org ([66.70.73.150]:50061 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266907AbSLDEuT>;
	Tue, 3 Dec 2002 23:50:19 -0500
Date: Wed, 4 Dec 2002 15:54:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Russell King <rmk@arm.linux.org.uk>
Cc: peterc@gelato.unsw.edu.au, linux-kernel@vger.kernel.org
Subject: Re: Ejecting an orinoco card causes hang
Message-ID: <20021204045420.GI1564@zax.zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Russell King <rmk@arm.linux.org.uk>, peterc@gelato.unsw.edu.au,
	linux-kernel@vger.kernel.org
References: <15797.63740.520358.783516@wombat.chubb.wattle.id.au> <20021023085501.A22736@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021023085501.A22736@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 08:55:02AM +0100, Russell King wrote:
> On Wed, Oct 23, 2002 at 11:18:52AM +1000, peterc@gelato.unsw.edu.au wrote:
> > 4.  Transferring lots of data causes the link to collapse, and the
> >     logs to fill up with `eth0: Error -110 writing Tx descriptor to
> >     BAP' messages
> 
> I see type of behaviour this with an Orinoco Silver card while trying to
> set the mode/essid.  I took the wvlan_cs code from my RH7.2 box and dropped
> it into 2.5 - seems to work (although how reliable it is I don't know yet;
> I need to get something for this card to talk to.)

Sadly, I'm still battling this particular problem.  However, I have
just fixed a bug which could cause hangs on eject.  It's in the
"testing" version at
http://www.ozlabs.org/people/dgibson/dldwd/testing.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
