Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267021AbTAFQNq>; Mon, 6 Jan 2003 11:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267022AbTAFQNq>; Mon, 6 Jan 2003 11:13:46 -0500
Received: from pusa.informat.uv.es ([147.156.10.98]:21192 "EHLO
	pusa.informat.uv.es") by vger.kernel.org with ESMTP
	id <S267021AbTAFQNp>; Mon, 6 Jan 2003 11:13:45 -0500
Date: Mon, 6 Jan 2003 17:22:17 +0100
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_X86_TSC_DISABLE question
Message-ID: <20030106162217.GC10554@pusa.informat.uv.es>
References: <20030103225806.GA10646@pusa.informat.uv.es> <Pine.LNX.4.44.0301031800370.29107-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0301031800370.29107-100000@coffee.psychology.mcmaster.ca>
User-Agent: Mutt/1.3.28i
From: uaca@alumni.uv.es
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2003 at 06:01:13PM -0500, Mark Hahn wrote:
> > I think that CONFIG_X86_TSC_DISABLE should be more informative on this
> 
> at most, it should say "don't worry about this unless you need to.
> and you'll know it if you need to".


And It should say that the kernel test TSCs are syncroniced across CPUS at
boot time, which I've just have found:

The message is the following in a 2.4.19-pre6 kernel

checking TSC synchronization across CPUs: passed.


I hope this helps somebody


	Ulisses

                Debian GNU/Linux: a dream come true
-----------------------------------------------------------------------------
"Computers are useless. They can only give answers."            Pablo Picasso

--->	Visita http://www.valux.org/ para saber acerca de la	<---
--->	Asociación Valenciana de Usuarios de Linux		<---
 
