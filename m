Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281250AbRKERWw>; Mon, 5 Nov 2001 12:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281248AbRKERWm>; Mon, 5 Nov 2001 12:22:42 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:29487 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S281250AbRKERW3>; Mon, 5 Nov 2001 12:22:29 -0500
Date: Mon, 5 Nov 2001 18:20:47 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Robert Love <rml@tech9.net>, Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.13-ac5-preempt, overflow in cached memory stat?
Message-ID: <20011105182047.E18319@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0111051019080.6741-100000@netfinity.realnet.co.sz>, <Pine.LNX.4.33.0111051019080.6741-100000@netfinity.realnet.co.sz> <1004948146.806.4.camel@phantasy> <3BE64FE3.DBEF8E21@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3BE64FE3.DBEF8E21@zip.com.au>; from akpm@zip.com.au on Mon, Nov 05, 2001 at 12:37:55AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2001 at 12:37:55AM -0800, Andrew Morton wrote:
> Robert Love wrote:
> > 
> > > PS I know you keep hearing this, but that preempt patch makes for some
> > > damn smooth interactive performance ;)
> > 
> > I can't hear it enough :)
> > 
> 
> umm...  Look.  Sorry.  But I don't see any theoretical reason
> why interactivity should be noticeably different from the
> little patch at
> 
> http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.14pre7aa2/00_lowlatency-fixes-2

indeed, the only thing that PE can really change is the mean latency but
everbody only cares about worst case latency and nominal performance,
possibly except realtime signal processing (not multimedia playback
like listening mp3).

Andrea
