Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261603AbREOVs6>; Tue, 15 May 2001 17:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261607AbREOVss>; Tue, 15 May 2001 17:48:48 -0400
Received: from nat-hdqt.valinux.com ([198.186.202.17]:57592 "EHLO tytlal")
	by vger.kernel.org with ESMTP id <S261603AbREOVsh>;
	Tue, 15 May 2001 17:48:37 -0400
Date: Tue, 15 May 2001 14:46:56 -0700
From: Chip Salzenberg <chip@valinux.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: James Simmons <jsimmons@transvirtual.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <20010515144656.J3098@valinux.com>
In-Reply-To: <Pine.LNX.4.10.10105151028380.22038-100000@www.transvirtual.com> <Pine.GSO.4.21.0105151330480.21081-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.GSO.4.21.0105151330480.21081-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Tue, May 15, 2001 at 01:32:23PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Alexander Viro:
> On Tue, 15 May 2001, James Simmons wrote:
> > I would use write except we use write to draw into the framebuffer. If I
> > write to the framebuffer with that data the only thing that will happen is
> > I will get pretty colors on my screen. 
> 
> Yes. And we also use write to send data to printer. So what? Nobody makes
> you use the same file.

You're talking about /dev/fb0 vs. /dev/fb0ctl, right?

Would that driver authors routinely used such clean designs.

PS: No, readers, AFAIK, there is no such thing as /dev/fb0ctl.  Yet.
-- 
Chip Salzenberg              - a.k.a. -             <chip@valinux.com>
 "We have no fuel on board, plus or minus 8 kilograms."  -- NEAR tech
