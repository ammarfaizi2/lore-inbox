Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136614AbREGTDB>; Mon, 7 May 2001 15:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136618AbREGTCw>; Mon, 7 May 2001 15:02:52 -0400
Received: from jalon.able.es ([212.97.163.2]:55427 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S136617AbREGTCm>;
	Mon, 7 May 2001 15:02:42 -0400
Date: Mon, 7 May 2001 21:02:29 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Helge Hafting <helgehaf@idb.hist.no>
Cc: Tobias Ringstrom <tori@tellus.mine.nu>, linux-kernel@vger.kernel.org
Subject: Re: page_launder() bug
Message-ID: <20010507210229.A7724@werewolf.able.es>
In-Reply-To: <Pine.LNX.4.33.0105070823060.24073-100000@svea.tellus> <3AF663F1.E04D90CE@idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3AF663F1.E04D90CE@idb.hist.no>; from helgehaf@idb.hist.no on Mon, May 07, 2001 at 10:59:29 +0200
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.07 Helge Hafting wrote:
> Tobias Ringstrom wrote:
> > 
> > On Sun, 6 May 2001, David S. Miller wrote:
> > > It is the most straightforward way to make a '1' or '0'
> > > integer from the NULL state of a pointer.
> > 
> > But is it really specified in the C "standards" to be exctly zero or one,
> > and not zero and non-zero?
> 
> !0 is 1.  !(anything else) is 0.  It is zero and one, not
> zero and "non-zero".  So a !! construction gives zero if you have
> zero, and one if you had anything else.  There's no doubt about it.
> >

Isn't this asking for trouble with the optimizer ? It could kill both
!!. Using that is like trusting on a certain struct padding-alignment.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Linux Mandrake release 8.1 (Cooker) for i586
Linux werewolf 2.4.4-ac5 #1 SMP Sat May 5 01:17:07 CEST 2001 i686

