Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267404AbSKPXUR>; Sat, 16 Nov 2002 18:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267405AbSKPXUR>; Sat, 16 Nov 2002 18:20:17 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:23985 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267404AbSKPXUQ>; Sat, 16 Nov 2002 18:20:16 -0500
Subject: Re: lan based kgdb
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <ar4h11$g7n$1@penguin.transmeta.com>
References: <3DD5591E.A3D0506D@efi.com> <334960000.1037397999@flay>
	<ar3op8$f20$1@penguin.transmeta.com>
	<20021115222430.GA1877@tahoe.alcove-fr> 
	<ar4h11$g7n$1@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 16 Nov 2002 23:54:09 +0000
Message-Id: <1037490849.24843.11.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-11-16 at 04:19, Linus Torvalds wrote:
> But it should be possible to do a really simple UDP-packets-only thing
> for kgdb.  Sure, it may lose packets.  Tough.  Don't debug over a WAN,
> and try to keep a clean direct network connection if you are worried
> about it.  But we want kernel printk's to be synchronous anyway, without
> timeouts etc.

And in the real world you end up back with TCP. Been there, done that
with network debugger tools before.

Alan

