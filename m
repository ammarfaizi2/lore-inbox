Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbTFQJsD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 05:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbTFQJsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 05:48:02 -0400
Received: from [213.196.40.44] ([213.196.40.44]:49637 "EHLO blackstar.nl")
	by vger.kernel.org with ESMTP id S261566AbTFQJsA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 05:48:00 -0400
Date: Tue, 17 Jun 2003 12:01:40 +0200 (CEST)
From: bvermeul@blackstar.nl
To: Russell King <rmk@arm.linux.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with PCMCIA/Orinoco
In-Reply-To: <20030617105544.D25452@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0306171159470.1854-100000@blackstar.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jun 2003, Russell King wrote:

> On Tue, Jun 17, 2003 at 11:29:00AM +0200, bvermeul@blackstar.nl wrote:
> > I'm having some problems with 2.5.71 (latest bk yesterday I believe).
> > All works well (pcmcia works as advertised, with one tiny blip on
> > the horizon), except when I want to reboot, when I get the following
> > message:
> > 
> > unregister_netdevice: waiting for eth1 to become free. Usage count = 1
> > 
> > The net device is an Orinoco mini-pci card (eg, cardbus minipci interface 
> > with built-in orinoco card), and it is down.
> > 
> > I'm not sure what causes this, and it's started somewhere in 2.5.70 bk.
> 
> I believe this is a netdevice problem and isn't anything to do with
> PCMCIA or Cardbus.  If the net people would like to confirm this, it'd
> be most helpful.

I'm also using a RTL8139 cardbus card, and that does not show this 
particular problem (works great actually).
So I'm not so sure it is a netdevice problem. It may be a orinoco
problem, but I'm not entirely sure what's causing it.
Just wanted to see if anyone's noticed it as well, and if a fix was
out there.

Bas Vermeulen

