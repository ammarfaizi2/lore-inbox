Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262109AbSJIXdr>; Wed, 9 Oct 2002 19:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262131AbSJIXdq>; Wed, 9 Oct 2002 19:33:46 -0400
Received: from grue.ucsd.edu ([132.239.66.103]:12929 "EHLO grue.ucsd.edu")
	by vger.kernel.org with ESMTP id <S262109AbSJIXdg>;
	Wed, 9 Oct 2002 19:33:36 -0400
Date: Wed, 09 Oct 2002 16:39:20 -0700 (PDT)
Message-Id: <20021009.163920.85414652.wlandry@ucsd.edu>
To: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: A simple request (was Re: boring BK stats)
From: Walter Landry <wlandry@ucsd.edu>
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> If you can't fit a whole tree including metadata into RAM, though,
> BK crawls... Going from "bk citool" at the command line to actually
> seeing the citool window approaches five minutes of runtime, on this
> 200MB laptop... [my dual athlon with 512MB RAM corroborates your
> numbers, though] "bk -r co -Sq" takes a similar amount of time...
> 
> I also find that BK brings out the worst in the 2.4 kernel
> elevator/VM... mouse clicks in Mozilla take upwards of 10 seconds to
> respond, when "bk -r co -Sq" is running on this laptop [any other
> read-from-disk process behaves similarly]. And running any two BK
> jobs at the same time is a huge mistake. Two "bk -r co -Sq" runs
> easily take four or more times longer than a single run. Ditto for
> consistency checks, or any other disk-intensive activity BK indulges
> in.

Hello,

What kind of CPU and hard drive do your two machines above have?  I'm
a developer for arch[1], and I'm wondering how fast things can get.

Note: If you answer, you'll certainly be aiding arch development.  It
      might be interpreted as "develop[ing] ... a product which
      contains substantially similar capabilities of the BitKeeper
      Software, or, in the reasonable opinion of BitMover, competes
      with the BitKeeper Software".  So you might lose the ability to
      use the free license.  But I'll let you decide if you want to
      help us.

Thank you,
Walter Landry
wlandry@ucsd.edu

[1] www.fifthvision.net/Arch

