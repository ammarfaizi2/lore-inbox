Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278391AbRJMUON>; Sat, 13 Oct 2001 16:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278394AbRJMUNz>; Sat, 13 Oct 2001 16:13:55 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:46596 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S278391AbRJMUMx>;
	Sat, 13 Oct 2001 16:12:53 -0400
Date: Sat, 6 Oct 2001 00:27:41 +0000
From: Pavel Machek <pavel@suse.cz>
To: David Woodhouse <dwmw2@infradead.org>
Cc: adam.keys@HOTARD.engr.smu.edu, linux-kernel@vger.kernel.org
Subject: journaling and devel [was Re: Development Setups]
Message-ID: <20011006002741.A35@toy.ucw.cz>
In-Reply-To: <20011005041759.OPDP14306.femail26.sdc1.sfba.home.com@there> <19213.1002268923@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <19213.1002268923@redhat.com>; from dwmw2@infradead.org on Fri, Oct 05, 2001 at 09:02:03AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I was thinking of starting with a modern machine for developing/
> > compiling on,  and then older machine(s) for testing.  This way I
> > would not risk losing data  if I oops or somesuch. 
> 
> With journalling filesystems you needn't worry _too_ much about losing 
> data; depending of course on what you're hacking on. Having two separate 
> boxen for development and testing is mostly valuable because you can keep 
> working when you break it - it doesn't take your entire desktop environment 
> down with it.

I disagree.. With journal filesystem, when something is silently corrupting
your disk, you'll never know. With ext2, you sometimes sync & reset to make
sure your disks are still healthy. I would not recommend journaling on 
experimental boxes.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

