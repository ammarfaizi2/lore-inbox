Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131986AbRDCOdr>; Tue, 3 Apr 2001 10:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131979AbRDCOdi>; Tue, 3 Apr 2001 10:33:38 -0400
Received: from toscano.org ([64.50.191.142]:737 "HELO bubba.toscano.org")
	by vger.kernel.org with SMTP id <S131986AbRDCOd1>;
	Tue, 3 Apr 2001 10:33:27 -0400
Date: Tue, 3 Apr 2001 10:32:45 -0400
From: Pete Toscano <pete.lkml@toscano.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Stuck: What to do with solid locks?
Message-ID: <20010403103245.B1713@bubba.toscano.org>
Mail-Followup-To: Pete Toscano <pete.lkml@toscano.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20010403001611.A1519@bubba.toscano.org> <E14kPqt-0007wJ-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14kPqt-0007wJ-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Apr 03, 2001 at 01:24:01PM +0100
X-Unexpected: The Spanish Inquisition
X-Uptime: 10:18am  up 19 min,  1 user,  load average: 0.09, 0.09, 0.08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, I realize this.  I don't mind and even expect the occational crash
right now in the 2.4.x series, but the frequency of these crashes fall
into the "frequent" category.  I know that if I want a much more stable
system, I should go back to 2.2.19, but I'd prefer to stick it out with
2.4.x and help by collecting data.  The data collection part is all (I
think) I can do, as I don't know the first place to begin when it comes
to fixing most kernel problems.  I know it's not much, but it's about
all I can do to give something back to the Linux community and I'd
really like to help.  The message I wrote last night was a bit too whiny
as I had just had three crashes/locks within a fairly short period of
time.

The most frustrating part is these solid locks.  I don't even have KDB
to nose about the system with.  Even when the system does crash to KDB,
I don't get Oops messages, just "kernel cannot handle NULL paging
request"-sort of stuff.  Nothing ever gets logged to (k)syslogd (or, at
least, handled by (k)syslogd).  Keith Owens has been great about helping
me us KDB to try to collect data for people who might be able to track
down bugs, but if I can't get into KDB even, then I have no idea where
to begin to help fix this problem (or these problems).

pete

On Tue, 03 Apr 2001, Alan Cox wrote:

> > This is very frustrating.  I really, really want to be able to start
> > doing something on my workstation without having to worry everytime
> > about it crashing.
> 
> Then install 2.2.19. 2.4.x isnt stable yet. If you have the time then oopses
> and debugging data are wonderful if not then 2.2 is stable.
> 
> 
> Alan
> 
