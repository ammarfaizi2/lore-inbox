Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281411AbRKEW7w>; Mon, 5 Nov 2001 17:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281416AbRKEW7m>; Mon, 5 Nov 2001 17:59:42 -0500
Received: from borderworlds.dk ([193.162.142.101]:59152 "HELO
	klingon.borderworlds.dk") by vger.kernel.org with SMTP
	id <S281411AbRKEW7g>; Mon, 5 Nov 2001 17:59:36 -0500
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ext2 directory index, updated
In-Reply-To: <20011104022659Z16995-4784+750@humbolt.nl.linux.org>
	<m3hesatcgq.fsf@borg.borderworlds.dk>
	<20011105014225Z17055-18972+38@humbolt.nl.linux.org>
From: Christian Laursen <xi@borderworlds.dk>
Date: 05 Nov 2001 23:59:33 +0100
In-Reply-To: <20011105014225Z17055-18972+38@humbolt.nl.linux.org>
Message-ID: <m3n120x1re.fsf@borg.borderworlds.dk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@bonn-fries.net> writes:

> On November 4, 2001 11:09 pm, Christian Laursen wrote:
> > Daniel Phillips <phillips@bonn-fries.net> writes:
> > 
> > > ***N.B.: still for use on test partitions only.***
> > 
> > It's the first time, I've tried this patch and I must say, that
> > the first impression is very good indeed.
> > 
> > I took a real world directory (my linux-kernel MH folder containing
> > roughly 115000 files) and did a 'du -s' on it.
> > 
> > Without the patch it took a little more than 20 minutes to complete.
> > 
> > With the patch, it took less than 20 seconds. (And that was inside uml)
> 
> Which kernel are you using?

Actually, it was on a 2.2.20 kernel.

> From 2.4.10 on ext2 has an accelerator in 
> ext2_find_entry - it caches the last lookup position.  I'm wondering how that 
> affects this case.

>From the description I read a while ago, I believe it could cause a significant
speedup.

I'll have to try that out one of these days.

-- 
Best regards
    Christian Laursen
