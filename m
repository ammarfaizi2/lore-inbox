Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317512AbSGOQhU>; Mon, 15 Jul 2002 12:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317536AbSGOQhT>; Mon, 15 Jul 2002 12:37:19 -0400
Received: from chaos.analogic.com ([204.178.40.224]:65154 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317512AbSGOQhS>; Mon, 15 Jul 2002 12:37:18 -0400
Date: Mon, 15 Jul 2002 12:42:31 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Weber, Frank" <FWeber@ndsuk.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Process-wise swap-on/off option
In-Reply-To: <1A961872F9CE0B4AB641DD256115865F225C5E@tornado.uk.nds.com>
Message-ID: <Pine.LNX.3.95.1020715124057.21519A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jul 2002, Weber, Frank wrote:

> Hello:
> 
> Is it possible to arrange that a Linux application 
> (or one of its threads) has the ability to
> 
> 	"... lock (a certain) stack and data segment ... 
> 	into memory so that it can't be swapped out"?
> 
> [This has been formulated as a requirement by one of 
> our analysts.]
> 
> I have been told that this is unlikely (except by 
> disabling swapout altogether (for all processes). 
> 
> Any hints as to where to look for a solution (i.e., 
> pointers to documentation or manuals where the ifs 
> and hows are explained) would be greatly appreciated.
> 
> Many thanks in advance,
> F.P.Weber

Sure. mlock() and mlockall().

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

