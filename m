Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267405AbSKPXWV>; Sat, 16 Nov 2002 18:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267406AbSKPXWV>; Sat, 16 Nov 2002 18:22:21 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:24753 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267405AbSKPXWU>; Sat, 16 Nov 2002 18:22:20 -0500
Subject: Re: lan based kgdb
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Mosberger-Tang <David.Mosberger@acm.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <ugadkaase6.fsf@panda.mostang.com>
References: <3DD5591E.A3D0506D@efi.com> <334960000.1037397999@flay>
	<ar3op8$f20$1@penguin.transmeta.com>
	<20021115222430.GA1877@tahoe.alcove-fr>
	<ar4h11$g7n$1@penguin.transmeta.com>  <ugadkaase6.fsf@panda.mostang.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 16 Nov 2002 23:56:14 +0000
Message-Id: <1037490974.24777.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-11-16 at 07:24, David Mosberger-Tang wrote:
> hit by a breakpoint that is in the way of the gdb I/O.  The code is
> almost too trivial to mention, but for anyone interested, it can still
> be found at:
> 
> 	http://www.cs.arizona.edu/scout/software.html
> 
> The relevant files are scout/sys/ai/kgdb_net.c and
> scout/router/tulip/tulip.c (the latter contains the Ethernet driver
> portion).

Very nice. That solves the debugger question elegantly. I'd still rather
have tcp for a console control though 8)

