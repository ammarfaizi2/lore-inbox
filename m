Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265171AbTANUSj>; Tue, 14 Jan 2003 15:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265198AbTANUSi>; Tue, 14 Jan 2003 15:18:38 -0500
Received: from chaos.analogic.com ([204.178.40.224]:63110 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265171AbTANUSh>; Tue, 14 Jan 2003 15:18:37 -0500
Date: Tue, 14 Jan 2003 15:28:23 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Mark Mielke <mark@mark.mielke.cc>
cc: DervishD <raul@pleyades.net>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Changing argv[0] under Linux.
In-Reply-To: <20030114202359.GD15412@mark.mielke.cc>
Message-ID: <Pine.LNX.3.95.1030114152443.13840C-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2003, Mark Mielke wrote:

> On Tue, Jan 14, 2003 at 02:56:35PM -0500, Richard B. Johnson wrote:
> > Well I just grepped through usr/include/bits/posix1_lim.h and it
> > shows 255 (with this 'C' library) so you are probably right.
> > In any event, a "whole line of text" isn't going to overrun it. 
> 
> Looking at the code, it looks to me as if argv[0] can be any size up to
> _SC_ARG_MAX, with the restraining factor being that the environment
> variables and the other arguments must fit in the same space.
> 
> Is this not correct?
> 
> mark

Don't think so. In my headers _SC_ARG_MAX is an enumerated type
that is numerically equal to 0. It's in confname.h, the first
element in the enumerated list.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


