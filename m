Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129381AbRBUX4l>; Wed, 21 Feb 2001 18:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129534AbRBUX4b>; Wed, 21 Feb 2001 18:56:31 -0500
Received: from [199.239.160.155] ([199.239.160.155]:21259 "EHLO
	tenchi.datarithm.net") by vger.kernel.org with ESMTP
	id <S129381AbRBUX4U>; Wed, 21 Feb 2001 18:56:20 -0500
Date: Wed, 21 Feb 2001 15:56:18 -0800
From: Robert Read <rread@datarithm.net>
To: linux-kernel@vger.kernel.org
Subject: Re: newbie fodder
Message-ID: <20010221155618.B8640@tenchi.datarithm.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <UTC200102212223.XAA133762.aeb@vlet.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <UTC200102212223.XAA133762.aeb@vlet.cwi.nl>; from Andries.Brouwer@cwi.nl on Wed, Feb 21, 2001 at 11:23:51PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This looks great, in fact I was working on something similar for
myself.  Unfortunately, like all good documentation, it's already
slightly out of date.  Just this morning I noticed that as of the
2.4.2-preX, the __make_request function no longer contains this code:

       if (!q->plugged)
               q->request_fn(q);

I don't know why the change was made, and I have not yet found where
how q->request_fn gets called for non-plugged request queues, but
since this is one of the key steps of the whole process, it will be
great to keep this documentation current.

robert

On Wed, Feb 21, 2001 at 11:23:51PM +0100, Andries.Brouwer@cwi.nl wrote:
> For a beginner I recently wrote a tiny demonstration
> of what the kernel does, given a trivial user program.
> Now that it served its purpose it would be a pity to
> throw it out again, maybe it can be useful to someone else.
> 
> See
> 	http://www.win.tue.nl/~aeb/linux/vfs/trail-1.html
> 
> Andries
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
