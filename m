Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267485AbTBDWHZ>; Tue, 4 Feb 2003 17:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267484AbTBDWHY>; Tue, 4 Feb 2003 17:07:24 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28177 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267485AbTBDWHY>; Tue, 4 Feb 2003 17:07:24 -0500
Date: Tue, 4 Feb 2003 14:14:06 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: gcc 2.95 vs 3.21 performance
In-Reply-To: <p73znpbpuq3.fsf@oldwotan.suse.de>
Message-ID: <Pine.LNX.4.44.0302041412210.2638-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 4 Feb 2003, Andi Kleen wrote:
> 
> If you want small and fast use lcc.

lcc isn't really something I want to use, since the license is so strange, 
and thus can't be improved upon if there are issues with it.

Some people have used the Intel compiler - which obviously also cannot be
improved upon, but which is likely to start off pretty good. I don't
really want to use it myself - what I'd really like to see is gcc
splitting up just the C compiler as a separate project with more attention
to size and speed.

		Linus

