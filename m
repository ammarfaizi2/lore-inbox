Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbWE2UVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWE2UVH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 16:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWE2UVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 16:21:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10727 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751279AbWE2UVG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 16:21:06 -0400
Date: Mon, 29 May 2006 13:20:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Gabor Gombas <gombasg@sztaki.hu>
cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Kyle McMartin <kyle@mcmartin.ca>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add compile domain (was: Re: [PATCH] Well, Linus seems
 to like Lordi...)
In-Reply-To: <20060529120821.GD22245@boogie.lpds.sztaki.hu>
Message-ID: <Pine.LNX.4.64.0605291318420.5623@g5.osdl.org>
References: <20060525141714.GA31604@skunkworks.cabal.ca>
 <Pine.LNX.4.61.0605251829410.6951@yvahk01.tjqt.qr> <Pine.LNX.4.64.0605250943520.5623@g5.osdl.org>
 <20060529120821.GD22245@boogie.lpds.sztaki.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 May 2006, Gabor Gombas wrote:
> 
> Which full hostname? I have access to a machine with 2 NICs having 5
> IPv4 addresses total, and none of the associated DNS records correspond
> to the hostname.

That is no less true for the non-full hostname.

The fact is, a hostname is a hostname, and not "5 different hostnames". 
You're right that it has nothing to do with the IP address, but where did 
I claim it did?

If you have to have a hostname (and we do - it's undeniably part of what 
UNIX networking does), it's much better to make the hostname be a fully 
qualified one. Because it's never worse than having just a non-qualified 
one, and it is often better, and avoids the whole confusion.

		Linus
