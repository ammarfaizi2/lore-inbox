Return-Path: <linux-kernel-owner+w=401wt.eu-S1752393AbWLQKtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393AbWLQKtn (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 05:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752394AbWLQKtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 05:49:43 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43097 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752392AbWLQKtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 05:49:42 -0500
Date: Sun, 17 Dec 2006 11:49:27 +0100
From: Pavel Machek <pavel@ucw.cz>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@lazybastard.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
Message-ID: <20061217104927.GA28629@elf.ucw.cz>
References: <20061213195226.GA6736@kroah.com> <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org> <f2b55d220612131238h6829f51ao96c17abbd1d0b71d@mail.gmail.com> <Pine.LNX.4.64.0612131259260.5718@woody.osdl.org> <20061216090532.GF4049@ucw.cz> <20061216110414.GA1862@lazybastard.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061216110414.GA1862@lazybastard.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well.. it is easier to debug in userspace. While bad hw access can
> > still kill the box, bad free() will not, and most bugs in early
> > developent are actually of 2nd kind.
> 
> Isn't that what qemu is for?

I do not think you can reasonably debug driver for new hardware under
qemu.

Anyway, doing it in userspace is just convenient.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
