Return-Path: <linux-kernel-owner+w=401wt.eu-S1030272AbXAKLmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbXAKLmM (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 06:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030262AbXAKLmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 06:42:12 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:47292 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030272AbXAKLmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 06:42:11 -0500
Date: Thu, 11 Jan 2007 12:42:02 +0100
From: Pavel Machek <pavel@ucw.cz>
To: emisca <emisca.ml@gmail.com>
Cc: suspend2-users@lists.suspend2.net, suspend-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Suspend-devel] asus p5ld2 se, serial port gone after suspend and i8042 problems (solved, pnpacpi=off needed)
Message-ID: <20070111114202.GC5945@elf.ucw.cz>
References: <414cba4e0701101409w4be38105vae7d185f4c2967bd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414cba4e0701101409w4be38105vae7d185f4c2967bd@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>    I've got it to work... I've forgot a thing when I tried pnpacpi=off...
>    I added with grub console temporarly, and in the second boot I forgot
>    to add it. Booting the kernel (before resume) with pnpacpi=off
>    definitely make the serial work.
>    Thanks.. perhaps this is an hack. How we can fix it in a cleaner
>    way?

Find out what is wrong and patch kernel to fix it? Now you know you
need to look at pnpacpi code...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
