Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264824AbUDWOSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264824AbUDWOSW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 10:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264830AbUDWOSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 10:18:22 -0400
Received: from dsl-gw-90.pilosoft.com ([69.31.90.1]:17126 "EHLO
	paix.pilosoft.com") by vger.kernel.org with ESMTP id S264824AbUDWOSV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 10:18:21 -0400
Date: Fri, 23 Apr 2004 10:15:54 -0400 (EDT)
From: alex@pilosoft.com
To: jamal <hadi@cyberus.ca>
cc: linux-kernel@vger.kernel.org, <netdev@oss.sgi.com>
Subject: Re: tcp vulnerability?  haven't seen anything on it here...
In-Reply-To: <1082640135.1059.93.camel@jzny.localdomain>
Message-ID: <Pine.LNX.4.44.0404231006440.8887-100000@paix.pilosoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And for something like a huge download to just regular joe, this is more
> of a nuisance assuming some kiddie has access between you and the
> server. OTOH, long lived BGP sessions are affected assuming you are
> going across hostile path to your peer.
Again - no hostile path necessary. Attack is brute-force and does not rely 
on MITM.

> So whats all this ado about nothing? Local media made it appear we are
> all about to die.
Pretty much.
> 
> Is anyone working on some fix?
In networking world, there was a craze of enabling TCP-MD5 for BGP
sessions reacting to this attack. There is alternative solution, "TTL
hack", relying that most BGP sessions are between directly-connected 
routers, so if connection originator sets TTL to 255 and receiver verifies 
that TTL on incoming packet is 255, you can be reasonably certain that the 
packet was sent by someone directly connected to you. ;)

-alex

