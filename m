Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261980AbVC1Snw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbVC1Snw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 13:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbVC1Snw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 13:43:52 -0500
Received: from digitalimplant.org ([64.62.235.95]:20910 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261980AbVC1Snu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 13:43:50 -0500
Date: Mon, 28 Mar 2005 10:43:39 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: David Brownell <david-b@pacbell.net>
cc: Alan Stern <stern@rowland.harvard.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: klists and struct device semaphores
In-Reply-To: <200503281016.15374.david-b@pacbell.net>
Message-ID: <Pine.LNX.4.50.0503281041150.29772-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0503261152160.13772-100000@netrider.rowland.org>
 <Pine.LNX.4.50.0503280856210.28120-100000@monsoon.he.net>
 <200503281016.15374.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 28 Mar 2005, David Brownell wrote:

> On Monday 28 March 2005 9:44 am, Patrick Mochel wrote:
>
> > How is this related to (8) above? Do you need some sort of protected,
> > short path through the core to add the device, but not bind it or add it
> > to the PM core?
>
> Erm, why is there a distinction between "adding device" and "adding it
> to the PM core"?  That's a conceptual problem right there.  There
> should be no distinctio.  (But it does make eminent sense to be able
> to add a device without necessarily binding it to a driver, since
> the "unbound driver" state is all over the place.)

Don't get too excited; there is no distinction.

He seemed to imply that it would be useful for interfaces to be added
without having the possibility of being suspended until all the interfaces
of a device were added. I'm simply trying to understand what he thinks is
necessary.


	Pat

