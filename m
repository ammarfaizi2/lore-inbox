Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262423AbTCMPgw>; Thu, 13 Mar 2003 10:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262424AbTCMPgw>; Thu, 13 Mar 2003 10:36:52 -0500
Received: from pusa.informat.uv.es ([147.156.10.98]:52426 "EHLO
	pusa.informat.uv.es") by vger.kernel.org with ESMTP
	id <S262423AbTCMPgv>; Thu, 13 Mar 2003 10:36:51 -0500
Date: Thu, 13 Mar 2003 16:47:26 +0100
To: Mark Hounschell <markh@compro.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: is irq smp affinity good for anything?
Message-ID: <20030313154726.GB24636@pusa.informat.uv.es>
References: <20030311140458.GA15465@pusa.informat.uv.es> <Pine.LNX.4.44.0303112047240.15753-100000@coffee.psychology.mcmaster.ca> <20030312101116.GB12206@pusa.informat.uv.es> <3E7076E1.6F7C74B1@compro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3E7076E1.6F7C74B1@compro.net>
User-Agent: Mutt/1.3.28i
From: uaca@alumni.uv.es
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 13, 2003 at 07:17:37AM -0500, Mark Hounschell wrote:
[...]
> If you also bind your task to the same cpu and force all other tasks from that
> cpu while doing the same with the irq, your determinism will improve greatly.
> Determinism being the difference in the best and worse case latencies. The
> smaller the better (jitter). This won't increase a single latency time but your
> determinism will be greatly improved.

Thanks so much for your comments

Yes... maybe there is also cache pingpong because common locks are in
different cpus... I'will try it

do you know what's the best/less intrusive patch that allows 
task cpu binding?

Thanks in advance again :-)

regards

	Ulisses

                Debian GNU/Linux: a dream come true
-----------------------------------------------------------------------------
"Computers are useless. They can only give answers."            Pablo Picasso

--->	Visita http://www.valux.org/ para saber acerca de la	<---
--->	Asociación Valenciana de Usuarios de Linux		<---
 
