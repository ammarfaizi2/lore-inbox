Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130264AbRBASpC>; Thu, 1 Feb 2001 13:45:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130866AbRBASow>; Thu, 1 Feb 2001 13:44:52 -0500
Received: from cnxt10215.conexant.com ([198.62.10.215]:1028 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S131490AbRBASof>; Thu, 1 Feb 2001 13:44:35 -0500
Date: Thu, 1 Feb 2001 19:42:50 +0100 (CET)
From: <rui.sousa@conexant.com>
To: Chris Evans <chris@scary.beasts.org>
cc: Malcolm Beattie <mbeattie@sable.ox.ac.uk>, <linux-kernel@vger.kernel.org>,
        <davem@redhat.com>
Subject: Re: Serious reproducible 2.4.x kernel hang
In-Reply-To: <Pine.LNX.4.30.0102011826060.397-100000@ferret.lmh.ox.ac.uk>
Message-ID: <Pine.LNX.4.30.0102011941290.739-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Feb 2001, Chris Evans wrote:

>
> Nope - I've nailed it to a _really_ simple test case. It looks like a
> read() on a shutdown() unix dgram socket just kills the kernel. Demo code
> below. I wonder if this affects UP or is SMP only?

It surely killed my PIII UP machine (running 2.4.1)

Rui Sousa

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
