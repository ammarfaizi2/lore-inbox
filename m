Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272316AbTG2VbP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 17:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272382AbTG2VbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 17:31:15 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:52231 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S272316AbTG2VbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 17:31:13 -0400
Date: Tue, 29 Jul 2003 22:31:11 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: neofb problems with 2.6.0-test1-ac3 etc. -- kernel-2.6.x ignoramus
In-Reply-To: <20030729203703.GG30351@charite.de>
Message-ID: <Pine.LNX.4.44.0307292230340.5874-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > fbset -depth 16
> > > 
> > > fixes things again. To see what I see, look at:
> > > http://sbserv.stahl.bau.tu-bs.de/~hildeb/fbfubar/
> > 
> > This is because the X server is not fbdev aware. Try adding the UseFBDev 
> > option in your XF86Config. That shoudl fix your problems.
> 
> Sorry, but this can't be: How comes the SAME X Server with the SAME
> XF86Config works OK with 2.4.22-pre8, but not with 2.6.x?
> 
> This is on the SAME machine, just with different kernel. Generally,
> all 2.4.x kernels don't show the problem, but 2.6.x does.

What is your configuration like for 2.4.X as compared to 2.5.X. Are you 
using the neofb driver in both cases?


