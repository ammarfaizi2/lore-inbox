Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131022AbRAJWGd>; Wed, 10 Jan 2001 17:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135365AbRAJWGX>; Wed, 10 Jan 2001 17:06:23 -0500
Received: from 154.145.126.209.cari.net ([209.126.145.154]:56325 "EHLO
	newportharbornet.com") by vger.kernel.org with ESMTP
	id <S131022AbRAJWGN>; Wed, 10 Jan 2001 17:06:13 -0500
Date: Wed, 10 Jan 2001 14:05:41 -0800 (PST)
From: Bob Lorenzini <hwm@ns.newportharbornet.com>
To: Hacksaw <hacksaw@hacksaw.org>
cc: kernel@ddx.a2000.nu, linux-kernel@vger.kernel.org
Subject: Re: unexplained high load
In-Reply-To: <200101102136.f0ALaEr01228@habitrail.home.fools-errant.com>
Message-ID: <Pine.LNX.4.21.0101101359450.5885-100000@newportharbornet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jan 2001, Hacksaw wrote:

> Ahh, a D state.
> 
> D means disk wait, which the only thing that can postpone a -9. Basic, the 
> process is stuck in a loop inside a routine that needs to be atomic.
> 
> You'll have to reboot to clear it. I believe this is a kernel bug. Try going 
> back to 2.2.14, or maybe up to 2.2.19pre2.

FYI at this moment I have a failing scsi tape format on a machine (2.2.18)
that has the same symtom (hung in D state, load=1).

Bob 










-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
