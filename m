Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268422AbTAMXbb>; Mon, 13 Jan 2003 18:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268412AbTAMXbb>; Mon, 13 Jan 2003 18:31:31 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:16769 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S268410AbTAMXb3>;
	Mon, 13 Jan 2003 18:31:29 -0500
Date: Mon, 13 Jan 2003 18:43:03 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jaroslav Kysela <perex@suse.cz>, Greg KH <greg@kroah.com>,
       Zwane Mwaikambo <zwane@holomorphy.com>, Shawn Starr <spstarr@sh0n.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PnP update - drivers
Message-ID: <20030113184302.GA24638@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Jaroslav Kysela <perex@suse.cz>, Greg KH <greg@kroah.com>,
	Zwane Mwaikambo <zwane@holomorphy.com>,
	Shawn Starr <spstarr@sh0n.net>, LKML <linux-kernel@vger.kernel.org>
References: <20030113173906.GA605@neo.rr.com> <Pine.LNX.4.44.0301131446380.15429-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301131446380.15429-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 02:48:45PM -0800, Linus Torvalds wrote:
> 
> On Mon, 13 Jan 2003, Adam Belay wrote:
> > 
> > I'm now unhappy with the current pnp code and will most likely revert all pnp
> > changes between 2.5.56 and 2.5.57 to avoid a merging nightmare.  I will then
> > carefully remerge what I feel is acceptable.
> 
> I will _not_ accept just stupid reverts, if that means that a device 
> driver is not available for people to test with.
> 
> We do not break drivers like that, and the reason you have clashes with 
> other people is that so many drivers ended up being broken for too long. 
> 
> Feel free to revert the changes one by one _as_they_get_fixed_. But don't 
> even try to send me a patch that reverts things to a broken state. The PnP 
> changes have been painful enough as-is.

Hi Linus,

I agree that it is important not to cause further damage to the existing pnp 
drivers.  Therefore I will carefully modify the drivers one by one before making
any changes to the pnp layer that would conflict.  In this way, all the pnp
drivers will remain functional during development.

Thanks,
Adam
