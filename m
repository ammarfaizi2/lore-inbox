Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274426AbRJNGSr>; Sun, 14 Oct 2001 02:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274427AbRJNGSg>; Sun, 14 Oct 2001 02:18:36 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:19 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S274426AbRJNGSc>; Sun, 14 Oct 2001 02:18:32 -0400
Date: Sun, 14 Oct 2001 08:18:56 +0200
From: Pavel Machek <pavel@suse.cz>
To: Robert Love <rml@ufl.edu>
Cc: Andrea Arcangeli <andrea@suse.de>, safemode <safemode@speakeasy.net>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-ac10-preempt lmbench output.
Message-ID: <20011014081856.A31943@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20011010003636Z271005-760+23005@vger.kernel.org> <20011010031803.F8384@athlon.random> <20011010020935.50DEF1E756@Cantor.suse.de> <20011010043003.C726@athlon.random> <1002681480.1044.67.camel@phantasy> <20011012132220.B35@toy.ucw.cz> <1003015290.864.70.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1003015290.864.70.camel@phantasy>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Now dbench (or any task) is in kernel space for too long.  The CPU time
> > > xmms needs will of course still be given, but _too late_.  Its just not
> > > a cpu resource problem, its a timing problem.  xmms needs x units of CPU
> > > every y units of time.  Just getting the x whenever is not enough.
> > 
> > Yep, with
> > 
> > x = 60msec
> > y = 600msec
> 
> How are you arriving at that y?  On what system?

Toshiba sattelite notebook. I remember being able to ^Z splay process
playing mp3, and bg-ing it in time not to skip. That means that y is
at least 300msec or so.

[I wanted to retry it on k6/400 with sblive and mpg123 (not splay) and
could not do the trick.]
							Pavel
-- 
Casualities in World Trade Center: 6453 dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
