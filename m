Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261884AbSJEAcr>; Fri, 4 Oct 2002 20:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261888AbSJEAcr>; Fri, 4 Oct 2002 20:32:47 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58118 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261884AbSJEAcq>; Fri, 4 Oct 2002 20:32:46 -0400
Date: Fri, 4 Oct 2002 17:40:04 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: oops in bk pull (oct 03)
In-Reply-To: <Pine.GSO.4.21.0210042030020.21250-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0210041737500.2993-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 4 Oct 2002, Alexander Viro wrote:
> 
> It is repeatable, it does happen with current BK (well, as of couple
> of hours ago) and reverting pci/probe.c change apparently cures it.

Really? That probe.c diff is _really_ small, and looks truly obvious. In 
particular, I don't see how it could possibly cause that kind of 
behaviour. What am I missing?

		Linus

