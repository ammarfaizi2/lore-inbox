Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293131AbSC0Wew>; Wed, 27 Mar 2002 17:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293129AbSC0Wen>; Wed, 27 Mar 2002 17:34:43 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:19471 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S293159AbSC0Weg>; Wed, 27 Mar 2002 17:34:36 -0500
Date: Wed, 27 Mar 2002 14:34:27 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: DE and hot-swap disk caddies
Message-ID: <20020327143427.N6223@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200203252316.g2PNGD011116@numbat.Os2.Ami.Com.Au> <01c501c1d4874ce9180e0aa8c0@bridge> <20020326002128.L6223@pegasys.ws> <20020326190117.B324@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2002 at 07:01:18PM +0000, Pavel Machek wrote:
> Hi!
> 
> > > > > Linux doesn't support IDE hot swap at the drive level. Its basically
> > > > > waiting people to want it enough to either fund it or go write the code
> > > > > 
> > > > 
> > > > What needs to be done? How extensive is the surgery needed?
> > > 
> > 
> > IDE isn't really meant to allow hot swap but it can be done.
> > 
> > As Jeremy says, electrically it is difficult to do it with a
> > master+slave on one cable because you really must power down
> > the interface (cable) and that would mean downing both devices.
> 
> But that's not a problem most times, right? Downing device on same
> channel for 10 second it takes to plug it in should not be a problem.
> 								Pavel

Sure, just be sure you POWER down the device(s) and the
interface.  IDE is no more designed to be hot-swap than the
ISA buss.  It was originally a buss level emulation of a
specific Western Digital controller for ST506 drives.  Talk
to an EE familiar with the spec and implementations and make
sure that your card can either power down or go buffered
tristate.  Smoking can be hazardous to your computer's
health.

Disclaimer: I am not an Electronics Engineer, nor an expert
on IDE/ATA/ATAPI yadda, yadda, yadda.  I wrote because this
thread, while useful for the future  was on a tangent that
wasn't telling John Summerfield how he might actually do
what he wants, today.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
