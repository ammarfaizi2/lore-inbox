Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274147AbRISTaY>; Wed, 19 Sep 2001 15:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274148AbRISTaO>; Wed, 19 Sep 2001 15:30:14 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:1008
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S274147AbRIST37>; Wed, 19 Sep 2001 15:29:59 -0400
Date: Wed, 19 Sep 2001 12:30:18 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: the Gimp and pre11
Message-ID: <20010919123018.B12820@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010919034412.092EB9CF9@oscar.casa.dyndns.org> <1000907347.6897.8.camel@sonja>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1000907347.6897.8.camel@sonja>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 03:48:57PM +0200, Daniel Egger wrote:
> On Mit, 2001-09-19 at 05:44, Ed Tomlinson wrote:
> 
> > I am editing 6 Megapixel files (2800x2048) and things like rotations seem to 
> > have delays that were not happening with previous kernels.  My box has 320M.
> > Seems that pre11 does not swap out as much as pre10 so Gimp has less to work
> > with.
> 
> Since GIMP uses it's own memory management using a tile approach I
> hardly doubt this is caused by swap usage if you defined the maximum
> amount of memory GIMP should use correctly; though it may be that the
> kernel swaps out tiles that the tilemanager considers to be active (and
> thus in memory) this behaviour should not happen as long as the kernel
> is not to eagerly swapping out memory and considering that the tiles
> are referenced quite often it should not swap them to disc at all IF
> the recently introduced algorithms work correctly.
> 
> Anyhow, just to make sure, would you please mention much memory you
> assigned to GIMP and what else is running on the system?
> 

Also, try a test with pre11 with swap turned off, and see how that affects
your system.

Please note: I am not recommending running without swap under normal
circumstances...
