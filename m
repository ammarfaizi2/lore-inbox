Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbVF0LrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbVF0LrM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 07:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbVF0LrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 07:47:12 -0400
Received: from oldconomy.demon.nl ([212.238.217.56]:24531 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S261991AbVF0LrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 07:47:07 -0400
Subject: Re: Promise ATA/133 Errors With 2.6.10+
From: Erik Slagter <erik@slagter.name>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Justin Piszcz <jpiszcz@lucidpixels.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050627113301.GA8476@ucw.cz>
References: <Pine.LNX.4.63.0506241653580.31140@p34>
	 <1119688191.4293.5.camel@localhost.localdomain>
	 <Pine.LNX.4.63.0506250435110.32759@p34>
	 <1119808784.28649.41.camel@localhost.localdomain>
	 <1119867096.4020.59.camel@localhost.localdomain>
	 <20050627113301.GA8476@ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 27 Jun 2005 13:46:52 +0200
Message-Id: <1119872812.4020.94.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-8) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-27 at 13:33 +0200, Vojtech Pavlik wrote:
> On Mon, Jun 27, 2005 at 12:11:36PM +0200, Erik Slagter wrote:
> 
> > On Sun, 2005-06-26 at 18:59 +0100, Alan Cox wrote:
> > > On Sad, 2005-06-25 at 09:35, Justin Piszcz wrote:
> > > > > BTW2 could it be that somewhere a timeout has been lowered in recent
> > > > > kernels? That must have been pre-2.6.11 then.
> > > 
> > > Timeouts have not changed or have increased in fact.
> > 
> > Never mind, the offending harddisk has ceased to be yesterday, it is no
> > more.
> > 
> > What really bothers me, though, is that until the very last moment it
> > was alive, it didn't report any smart error, nor did any self test fail.
> > I guess IBM is to blame here :-(
>  
> Most drives report no SMART problems until they die. I've seen several
> drives who weren't able to read/write or at least remap bad sectors, and
> still their SMART statistics were almost perfect. The SMART event log
> included the errors, though.

In this case NONE of the smartctl -a output revealed any problem, not
the attribute values, not the event log, and not the selftest log
(performed nightly).

I guess it's a problem like a minimal bad contact on the pcb, because
when the drive has properly cooled down, it does function for a while,
then at a certain point (smartctl reports ~35 C) it stops spinning and
hangs the complete bus.

I'm done with it, it is going to be replaced asap.
