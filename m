Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271900AbTG2Qz2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 12:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271901AbTG2Qz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 12:55:28 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:15877 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271900AbTG2QzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 12:55:22 -0400
Date: Tue, 29 Jul 2003 17:55:18 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [PATCH] Framebuffer: client notification mecanism & PM
In-Reply-To: <1059487140.8537.35.camel@gaston>
Message-ID: <Pine.LNX.4.44.0307291753530.5874-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > matroxfb tried to use a 'dead' for handling hot removal, but your code
> > looks definitely saner
> 
> My code wasn't really intended to deal with hot-removal, more with
> "what happens if printk occurs during the Power Management suspend
> sequence", but I tried to keep the notification mecanism simple
> enough so it could be used for that as well. Also, indeed, the fbcon
> changes should deal with hot-removal in some way (though you surely
> also want to "deatch" from the fbdev's in this case).
> 
> Among other things that could be used for is live monitor insertion/
> removal detection (some HW are able to do that), "pivot" monitor
> kind of things, etc... typically via the mode_changed hook.

I knew it was a matter of time before "client" management would happen. 
Is this a 2.6.X thing tho or shoudl we wait for the next developement 
cycle. I don't mind working on experimental stuff.


