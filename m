Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261942AbTDAACu>; Mon, 31 Mar 2003 19:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261943AbTDAACu>; Mon, 31 Mar 2003 19:02:50 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50706 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261942AbTDAACu>; Mon, 31 Mar 2003 19:02:50 -0500
Date: Mon, 31 Mar 2003 16:13:10 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Wayne Whitney <whitney@math.berkeley.edu>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.5.65: Caching MSR_IA32_SYSENTER_CS kills dosemu
In-Reply-To: <Pine.LNX.4.44.0303311551040.2220-100000@mf1.private>
Message-ID: <Pine.LNX.4.44.0303311612060.6908-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 31 Mar 2003, Wayne Whitney wrote:
> 
> UP with preempt.  2.5.66 with the patch you sent still locks up.  I should
> mention that I am running two copies of a hacked XFree86 on two different
> sets of KVM hardware, but that doesn't require any kernel patches (well, a
> small one to the input layer).

Can you check dosemu in text mode to see if the kernel prints out
anything. I realize that not many things are relevant in text mode, but I
have this memory of dosemu at least historically supporting it. Maybe not
any more.

		Linus

