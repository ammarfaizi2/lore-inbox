Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130075AbRAXDMw>; Tue, 23 Jan 2001 22:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130200AbRAXDMm>; Tue, 23 Jan 2001 22:12:42 -0500
Received: from CPE-61-9-148-22.vic.bigpond.net.au ([61.9.148.22]:39318 "EHLO
	elektra.higherplane.net") by vger.kernel.org with ESMTP
	id <S130075AbRAXDMc>; Tue, 23 Jan 2001 22:12:32 -0500
Date: Wed, 24 Jan 2001 14:23:14 +1100
From: john slee <indigoid@higherplane.net>
To: Jonathan Earle <jearle@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Coding Style
Message-ID: <20010124142314.E7426@higherplane.net>
In-Reply-To: <28560036253BD41191A10000F8BCBD116BDCCB@zcard00g.ca.nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <28560036253BD41191A10000F8BCBD116BDCCB@zcard00g.ca.nortel.com>; from jearle@nortelnetworks.com on Tue, Jan 23, 2001 at 10:07:10AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 23, 2001 at 10:07:10AM -0500, Jonathan Earle wrote:
> > /*
> >  * I tend to find standard C comments easier to read.  They stand out,
> >  * especially for multiple lines (although I always try to put the :end:
> >  * on a separate line for clarity).
> >  */
> 
> I like this style for multiple line comments, but prefer the '//' for single
> liners.  Two less characters to type after all.  :)

and potentially no end of weird problems if you have mac users editing
your code...  suddenly a compiler may ignore the rest of a file starting
at a given // or # comment, and you'll find its caused by their
different linebreaks.  had this problem with php.  havent seen it with C
yet.  does gcc handle non-correct^H^H^H^H^H^H^Hunix linebreaks now?  it
didnt when i used djgpp all those years ago.

// are nicer on the eyes, for short comments.  and death to capital
// letters.  and oooh, vim auto-extends // comments, thats handy isn't
// it! :-]

j.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
