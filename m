Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284182AbRLWXGf>; Sun, 23 Dec 2001 18:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284147AbRLWXG0>; Sun, 23 Dec 2001 18:06:26 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:1544 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S284171AbRLWXGL>;
	Sun, 23 Dec 2001 18:06:11 -0500
Date: Sun, 23 Dec 2001 01:19:09 +0000
From: Pavel Machek <pavel@suse.cz>
To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
        svein.ove@aas.no,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: File copy system call proposal
Message-ID: <20011223011908.A40@toy.ucw.cz>
In-Reply-To: <200112100544.fBA5isV223458@saturn.cs.uml.edu> <E16GnIg-0000V5-00@starship.berlin> <20011220110936.A18142@atrey.karlin.mff.cuni.cz> <200112201338.OAA23947@mail48.fg.online.no> <20011220145328.C16650@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011220145328.C16650@unthought.net>; from jakob@unthought.net on Thu, Dec 20, 2001 at 02:53:28PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Now there's a real world example for you.
> 
> No graphical file manager would use it - how would you show progress
> information to the user when coping a single huge file ?

They can't do that today (think writeback)...

> So, someone might hack up a 'cp' that used it, and in a few years when
> everyone is at 2.4.x (where x >= version with copyfile()) maybe some
> distribution would ship it.
> 
> Take a look at Win32, then have it. Then, look further, and you'll see
> that they have system calls for just about everything else.  It's

Windows are stupid. But copyfile is different from read+write -- it 
allows you to do on-server copy and allows COW.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

