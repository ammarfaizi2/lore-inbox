Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279432AbRJ2UIT>; Mon, 29 Oct 2001 15:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279438AbRJ2UIJ>; Mon, 29 Oct 2001 15:08:09 -0500
Received: from web11303.mail.yahoo.com ([216.136.131.206]:12902 "HELO
	web11303.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S279432AbRJ2UHz>; Mon, 29 Oct 2001 15:07:55 -0500
Message-ID: <20011029200832.77853.qmail@web11303.mail.yahoo.com>
Date: Mon, 29 Oct 2001 12:08:32 -0800 (PST)
From: Alex Deucher <agd5f@yahoo.com>
Subject: Re: opl3sa2 sound driver and mixers
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15yIWa-0003lV-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW, this is with kernel 2.4.9, but it has been
happening with every 2.4 kernel I've tried on these
notebooks.  I haven't tried 2.2 kernels in so long I
can't remember if they acted the same or not. 

Alex

--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > sound works, but an extra mixer seems to always
> load. 
> > I always suspected t was because of code sharing
> or
> > somthing, but I thought I'd ask here to see if it
> was
> > a bug or just a quirk of the driver.  I don't have
> the
> > notebook on hand right, now do these are from
> memory. 
> > When I load sound, several modules get loaded,
> opl3sa2
> > and AD18?? (can't remember the number off hand). 
> 
> AD1848 - this is correct. The opl3sa2 is an AD1848
> compatible device
> and an MPU401 compatible device (and some other
> oddments). 
> 
> > What's strange is that 2 mixers seem to get
> loaded. 
> > The first is for a CS4??? (can't recall the exact
> 
> CS4232 - that mixer shouldnt be getting created.
> That is a bug. I'll take
> a look at it


__________________________________________________
Do You Yahoo!?
Make a great connection at Yahoo! Personals.
http://personals.yahoo.com
