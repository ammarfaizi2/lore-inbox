Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287545AbSAHBCM>; Mon, 7 Jan 2002 20:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287538AbSAHBCC>; Mon, 7 Jan 2002 20:02:02 -0500
Received: from quattro-eth.sventech.com ([205.252.89.20]:23050 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id <S287521AbSAHBBu>; Mon, 7 Jan 2002 20:01:50 -0500
Date: Mon, 7 Jan 2002 20:01:50 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Michael Cohen <lkml@ohdarn.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB Lockups
Message-ID: <20020107200150.T10145@sventech.com>
In-Reply-To: <1010449229.4069.6.camel@ohdarn.net> <20020107193600.S10145@sventech.com> <1010451492.4127.8.camel@ohdarn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1010451492.4127.8.camel@ohdarn.net>; from lkml@ohdarn.net on Mon, Jan 07, 2002 at 07:58:12PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2002, Michael Cohen <lkml@ohdarn.net> wrote:
> > > Tried with UHCI and JE driver. JE doesn't recognize the USB controller
> > > half the time.  It seems to me that this is similar to the problem
> > > with a saturated PCI bus that someone posted a latency fix for.
> > > I'd appreciate any input.  A similar machine does this on windows as
> > > well, too.  BIOS is as late as it gets.
> > 
> > Doesn't recognize the USB controller half the time? This is something I
> > would expect to either work all of the time, or none of the time.
> > 
> > Do you get any error messages?
> 
> The JE driver strangely seems to be an unstable beast on here.
> It more often does not work, though every once in a while it wakes up on
> boot.  I've stuck with the standard.  As for error messages, "No devices
> found" is the only one I get with the standard driver (when nothing is
> plugged in :).  Oh, it's SMP PIII.

It'll say that if usb-uhci is loaded since it has claimed all of the
host controllers.

What sort of instability are you seeing?

JE

