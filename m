Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267330AbSKPSSD>; Sat, 16 Nov 2002 13:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267331AbSKPSSD>; Sat, 16 Nov 2002 13:18:03 -0500
Received: from waste.org ([209.173.204.2]:2030 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S267330AbSKPSSA>;
	Sat, 16 Nov 2002 13:18:00 -0500
Date: Sat, 16 Nov 2002 12:24:54 -0600
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lan based kgdb
Message-ID: <20021116182454.GH19061@waste.org>
References: <3DD5591E.A3D0506D@efi.com> <334960000.1037397999@flay> <ar3op8$f20$1@penguin.transmeta.com> <20021115222430.GA1877@tahoe.alcove-fr> <ar4h11$g7n$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar4h11$g7n$1@penguin.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 16, 2002 at 04:19:45AM +0000, Linus Torvalds wrote:

> But it should be possible to do a really simple UDP-packets-only thing
> for kgdb.  Sure, it may lose packets.  Tough. Don't debug over a WAN,
> and try to keep a clean direct network connection if you are worried
> about it.  But we want kernel printk's to be synchronous anyway, without
> timeouts etc.

LAN latencies should be low enough that waiting on an ACK for each
packet will do just fine for error correction. If someone wants to do
remote debugging, they can ssh into a debugging machine on the same LAN.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
