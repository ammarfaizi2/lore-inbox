Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289295AbSANXfo>; Mon, 14 Jan 2002 18:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289292AbSANXfe>; Mon, 14 Jan 2002 18:35:34 -0500
Received: from svr3.applink.net ([206.50.88.3]:50953 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S289289AbSANXfT>;
	Mon, 14 Jan 2002 18:35:19 -0500
Message-Id: <200201142333.g0ENXDk18838@home.ashavan.org.>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: Reid Hekman <reid.hekman@ndsu.nodak.edu>, linux-kernel@vger.kernel.org
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
Date: Mon, 14 Jan 2002 17:30:51 -0600
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020114132618.G14747@thyrsus.com> <20020114153844.A20537@thyrsus.com> <1011046709.18003.45.camel@zeus>
In-Reply-To: <1011046709.18003.45.camel@zeus>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



OK, drop what you're holding and prepare to load up on rotten
tomatoes, but I know that there is a solution.    Inasmuch as I
am a fan of Linux and BeOS, I think that the way to go is
with just about everything (sans networking perhaps) built
as a kernel module just like what is being discussed.    Nothing
is simpler in BeOS than downloading a driver and plopping
it in $HOME/config/add-ons/kernel/busses/ieee1394 (most install
scripts do this for the user or provides a "drag this driver to here"
link.   And with BeOS, the boot menu allows one to disable 
"user add-ons" so that if there is a problem with the module, one 
can disable it.  

	Yes, this doesn't please the server folks.  For them,
I think that we should either leave the monolithic build as an
option or find a way to get rid off any penalties to using modules.

	BeOS, autoconfigures and loads all drivers in the
15 seconds or so that it takes to achieve a complete hard
boot.    That much said, BeOS only supports good hardware
and left ISA stuff to user to play with (via a GUI tool).   I really 
do not see the value of any more discussion of how to 
autoconfigure ISA/MCA/EISA/VLB cards.   The vast majority 
of people using those systems are:

1. Still stuck in DOS World
2. Use M$ anyway
3. Would be afraid to upgrade their kernel
4. Think it's cool to have a Beowulf cluster of 386s
5. Forgot to turn off their computers before they died
6. Ancient sattelite based missile silos which we
wouldn't want to touch anyhow.....


-- 
timothy.covell@ashavan.org.
