Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264766AbSJVQMA>; Tue, 22 Oct 2002 12:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264755AbSJVQKv>; Tue, 22 Oct 2002 12:10:51 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14610 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264760AbSJVQKp>; Tue, 22 Oct 2002 12:10:45 -0400
Date: Tue, 22 Oct 2002 17:16:51 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linuxguruguy <linuxguruguy@aaahawk.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.44 : move files from drivers/media/* ?
Message-ID: <20021022171651.B19251@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0210212136030.900-100000@localhost.localdomain> <1035173920.6385.1.camel@nofuture.deadbodies.net> <1035214293.24166.1.camel@nofuture.deadbodies.net> <1035215567.24166.3.camel@nofuture.deadbodies.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1035215567.24166.3.camel@nofuture.deadbodies.net>; from linuxguruguy@aaahawk.com on Mon, Oct 21, 2002 at 11:52:46AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2002 at 11:52:46AM -0400, linuxguruguy wrote:
> On Mon, 2002-10-21 at 11:31, grstuhrberg wrote:
> > 
> > > On Mon, 2002-10-21 at 21:45, Frank Davis wrote:
> > > > Hello all,
> > > >   There are video and radio drivers within
> > > > drivers/media/video and drivers/media/radio respectively.
> > > > 
> > > > Shouldn't those drivers move from drivers/media/video to drivers/video ? 
> > > > and same with radio (either a new directory or within an existing 
> > > > directory). It just seems that the drivers/media/ directory is unneeded. 
> > > > Thoughts?
> > > > 
> > > > Regards,
> > > > Frank
> 
>  I agree This gets very annoying and repetitive when trying to find files 

By that same argument, we should only have one directory containing all the
.c and .h files in the entire kernel source tree.

The files in drivers/media/video are _completely_ unrelated to
drivers/video.  If anything, drivers/video should become drivers/framebuffer,
which is what it really is.  This would get rid of the "video" confusion.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

