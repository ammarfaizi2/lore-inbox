Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262835AbTJTWDg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 18:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262844AbTJTWDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 18:03:36 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:53258 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S262835AbTJTWDe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 18:03:34 -0400
Date: Mon, 20 Oct 2003 15:03:31 -0700
From: jw schultz <jw@pegasys.ws>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Uncorrectable Error on IDE, significant accumulation
Message-ID: <20031020220331.GD11265@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20031020132705.GA1171@synertronixx3> <E1ABaqY-0000jn-NG@rhn.tartu-labor> <20031020145316.GB593@synertronixx3> <3F93FC7C.2090606@inet6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F93FC7C.2090606@inet6.fr>
User-Agent: Mutt/1.3.27i
X-Message-Flag: This message may contain content offensive to Atheists and servants of false gods.  Read at your own risk.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 20, 2003 at 05:17:16PM +0200, Lionel Bouton wrote:
> Konstantin Kletschke wrote the following on 10/20/2003 04:53 PM :
> 
> >Can a bad Powersupply or weak mainboard create Uncorrectable Errors on
> >HDDs? Again only a question to experience of this community...
> > 
> >
> 
> It certainly can temporarily (under load).
> 
> Try offloading some power strain by removing some peripherals (CD-ROM, 
> non-mandatory disk drive) and see if it solves your problem.
> 
> I might be mistaken (don't know the exact behavior of drive electronics) 
> but it seems unlikely that a bad PSU with underrated voltage could 
> damage a drive (overrated voltage is another matter). Usually under spec 
> PSUs fail to produce enough juice under load and the system simply 
> becomes unstable.

I don't know the specific drive electronics either.
It has also been many years since i studied the electrical
side of this stuff.

Undervolt, or voltage sag under load, is worse than
overvolt.  Overvolt can be caught with fuses or voltage
regulators neither of which can do aught with an undervolt.
If overvolt does get through things run just a bit warmer.

Undervolt on the other hand can cause VCC to drop to the
level where it can no longer represent a logic high value
but is instead in the range where it is neither 0 nor 1 and
logic gates start spending too much time in the transition
range where they act like amplifiers.  When that happens not
only do you get data corruption but things start heating up
big-time and the current drain goes way up.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
