Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRACXbL>; Wed, 3 Jan 2001 18:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129370AbRACXbB>; Wed, 3 Jan 2001 18:31:01 -0500
Received: from innerfire.net ([208.181.73.33]:41477 "HELO innerfire.net")
	by vger.kernel.org with SMTP id <S129324AbRACXan>;
	Wed, 3 Jan 2001 18:30:43 -0500
Date: Wed, 3 Jan 2001 15:34:06 -0800 (PST)
From: Gerhard Mack <gmack@innerfire.net>
To: Dan Aloni <karrde@callisto.yi.org>
cc: Alexander Viro <viro@math.psu.edu>, Dan Hollis <goemon@anime.net>,
        linux-kernel <linux-kernel@vger.kernel.org>, mark@itsolve.co.uk
Subject: Re: [RFC] prevention of syscalls from writable segments, breaking
 bug exploits
In-Reply-To: <Pine.LNX.4.21.0101040037200.21774-100000@callisto.yi.org>
Message-ID: <Pine.LNX.4.10.10101031531140.2507-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2001, Dan Aloni wrote:

> On Wed, 3 Jan 2001, Alexander Viro wrote:
> 
> > > > > without breaking anything. It also reports of such calls by using printk.
> > > > Get real.
> > > 
> > > Why do you always have to be insulting alex? Sheesh.
> > 
> > Sigh... Not intended to be an insult. Plain and simple advice. Idea is
> [..]
> 
> Did you notice that question was ambiguous? I understood that sentence in
> its other meaning, i.e, someone insulting Alex ;-)
> 
> Anyway, while it is agreed that you can't completely eliminate exploits,
> it is recommended that, it should be at least harder to create them, maybe
> it can even minimize the will to write them.
> 
> -- 
> Dan Aloni 
> dax@karrde.org
> 

You are much better off working on ways to reduce the number of processes
that need to be root..

As for these protections my system emails me when a process overflows it's
buffers,  But that's not a kernel function. ;) 

	Gerhard


--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
