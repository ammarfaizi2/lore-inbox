Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262215AbREQXbt>; Thu, 17 May 2001 19:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262216AbREQXbj>; Thu, 17 May 2001 19:31:39 -0400
Received: from thagdal.cloud9.co.uk ([194.154.180.82]:43530 "EHLO
	custard.cloud9.co.uk") by vger.kernel.org with ESMTP
	id <S262215AbREQXb2>; Thu, 17 May 2001 19:31:28 -0400
Date: Fri, 18 May 2001 00:31:17 +0100
From: James Fidell <james@cloud9.co.uk>
To: Ion Badulescu <ionut@moisil.cs.columbia.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: eepro100 rev 12 problems
Message-ID: <20010518003117.D27178@gluttony.corp.cloud9.co.uk>
In-Reply-To: <20010517165904.C24712@gluttony.corp.cloud9.co.uk> <200105171908.f4HJ8jD17107@moisil.dev.hydraweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200105171908.f4HJ8jD17107@moisil.dev.hydraweb.com>; from ionut@moisil.cs.columbia.edu on Thu, May 17, 2001 at 12:08:45PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ion Badulescu (ionut@moisil.cs.columbia.edu):
> On Thu, 17 May 2001 16:59:04 +0100, James Fidell <james@cloud9.co.uk> wrote:
> > I have two eepro100 interfaces in a machine, one rev 8, which works just
> > fine, and another rev 12, which appears as a device when the kernel boots
> > and can be configured with an IP address etc., but I can't get any data
> > in or out of it.  All the other hardware looks like it's working fine and
> > all my rev 8 cards work, so I'm led to ask, are there any known problems
> > with eepro100 rev 12 cards under 2.2.18?
> 
> Is this a real card, or is it built-in on the motherboard?

It's a real card.

> I don't think eepro100 has got much testing with rev > 9, though it should
> have worked. All eepro100 chips are supposed to be backwards compatible with
> the 82557, but maybe our driver initializes some registers in a way that
> upsets newer chips. Not having docs for the newer chips doesn't help,
> either...
> 
> Intel's own e100 driver probably works, their code does things differently if
> rev >= 12 (what they call the D102 revision). Give it a spin, I guess.

For various reasons that are far to boring to go into here, I'm not entirely
free in my choice of card.  What I'll probably do is try to get a rev 8 card
swapped in for the rev 12 one.  If I can't get a rev 8 card for that machine,
I'll go with the e100 driver and let you know what happens.

James
