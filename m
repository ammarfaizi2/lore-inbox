Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbTEKEnx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 00:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262357AbTEKEnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 00:43:53 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:63618
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S262352AbTEKEnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 00:43:52 -0400
Date: Sun, 11 May 2003 00:46:30 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Jos Hulzink <josh@stack.nl>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: irq balancing: performance disaster
In-Reply-To: <7750000.1052619248@[10.10.2.4]>
Message-ID: <Pine.LNX.4.50.0305110046020.15337-100000@montezuma.mastecende.com>
References: <200305110118.10136.josh@stack.nl> <7750000.1052619248@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 May 2003, Martin J. Bligh wrote:

> > While tackling bug 699, it became clear to me that irq balancing is the cause 
> > of the performance problems I, and all people using the SMP kernel Mandrake 
> > 9.1 ships, are dealing with. I got the problems with 2.5.69 too. After 
> > disabling irq balancing, the system is remarkably faster, and much more 
> > responsive. 
> > 
> > For those interested in the issue, please look at bug 699.
> 
> Could you test out this patch from Keith Mannthey if you're having trouble?
> It makes irq balance a config option, which makes it easier to disable.
> Various people have requested it, but I don't have a box to test it on ;-(
> Pulled out of -mjb tree, but should go onto mainline easily.

What's wrong with the noirqbalance parameter?

-- 
function.linuxpower.ca
