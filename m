Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264699AbSLaTFK>; Tue, 31 Dec 2002 14:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264702AbSLaTFK>; Tue, 31 Dec 2002 14:05:10 -0500
Received: from bitmover.com ([192.132.92.2]:5057 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S264699AbSLaTFH>;
	Tue, 31 Dec 2002 14:05:07 -0500
Date: Tue, 31 Dec 2002 11:13:31 -0800
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: [TGAFB] implement the imageblit acceleration hook
Message-ID: <20021231191331.GC5607@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
References: <20021231004138.A13860@twiddle.net> <Pine.LNX.4.44.0212311100260.2697-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212311100260.2697-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

By the way, we know there are some security holes in BKD.  We're just 
about to push bk-3.0.1 out the door which closes the ones we know about
but you might want to be careful until you upgrade.  Part of the reason
we provide hosting at bkbits.net is because then the security problems 
are our problem, not yours.  

We don't care if you run your own BKD, in fact we like it, the ultimate
vision is a world of servers, not some centralized single point of
failure, but until we've let the script kiddies beat on us for a bit
longer you might set up at bkbits.net and I'll help you with a trigger
which will autopush to there.  So you can have your local clones of
whatever, you push into it, it pushes into your-proj.bkbits.net and maybe
sends mail to an interest list.  Let me know if that would be useful
(it works, this is how we update linux.bkbits.net from linus.bkbits.net).

You may contact me offline and I'll tell you what the security problems
are (not doing it here for the obvious reason).

On Tue, Dec 31, 2002 at 11:00:56AM -0800, Linus Torvalds wrote:
> 
> On Tue, 31 Dec 2002, Richard Henderson wrote:
> >
> > Please pull from
> > 
> > 	bk://are.twiddle.net/tgafb-2.5
> 
> Richard, you forgot to restart bkd again. Maybe add it to your 
> initscripts?
> 
> 	bk://are.twiddle.net/tgafb-2.5: Connection refused
> 
> Heh,
> 
> 		Linus
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
