Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRAJVtc>; Wed, 10 Jan 2001 16:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136177AbRAJVtO>; Wed, 10 Jan 2001 16:49:14 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:41994 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id <S129933AbRAJVs6>;
	Wed, 10 Jan 2001 16:48:58 -0500
Date: Wed, 10 Jan 2001 22:49:27 +0100 (CET)
From: <kernel@ddx.a2000.nu>
To: Hacksaw <hacksaw@hacksaw.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: unexplained high load
In-Reply-To: <200101102136.f0ALaEr01228@habitrail.home.fools-errant.com>
Message-ID: <Pine.LNX.4.30.0101102247510.4377-100000@ddx.a2000.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Jan 2001, Hacksaw wrote:

> Ahh, a D state.
>
> D means disk wait, which the only thing that can postpone a -9. Basic, the
> process is stuck in a loop inside a routine that needs to be atomic.
looked at the dir created with the last ftp login
and found :

.nfs0000000000ca402500000006

so i think there is some lock from the nfs server or client

will try to restart nfs client
and see if this fixes it.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
