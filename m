Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbULUJaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbULUJaO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 04:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbULUJaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 04:30:14 -0500
Received: from king.bitgnome.net ([66.207.162.30]:33789 "EHLO
	king.bitgnome.net") by vger.kernel.org with ESMTP id S261374AbULUJaH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 04:30:07 -0500
Date: Tue, 21 Dec 2004 03:29:34 -0600
From: Mark Nipper <nipsy@bitgnome.net>
To: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AMD64: timer is running twice as fast as it should (again??)
Message-ID: <20041221092934.GA75158@king.bitgnome.net>
References: <87ekhkhf1j.fsf@londo.ultra.csn.tu-chemnitz.de> <20041220210909.GA49579@king.bitgnome.net> <87sm60auf3.fsf@londo.ultra.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sm60auf3.fsf@londo.ultra.csn.tu-chemnitz.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Dec 2004, Enrico Scholz wrote:
> > 	Seem like something specific to Fedora or the bk branch
> > then because I'm running 2.6.10-rc3 under x86_64 and it sleeps as
> > long as it should.
> 
> Thanks for your testing but I can reproduce it both with vanilla 2.6.9
> and 2.6.10-rc3. The used .config can be found at
> 
>           http://www.tu-chemnitz.de/~ensc/hw/amd64/config.txt

	Sounds like something specific to Fedora/glibc under
Fedora then.  I'm running Debian sid/gcc-3.4 and it works fine
under vanilla 2.6.10-rc3 (well, with reiser4 patches, but mostly
vanilla).

	I'd check to see if anyone else running Fedora x86_64 is
having similar troubles.

-- 
Mark Nipper                                                e-contacts:
4475 Carter Creek Parkway                           nipsy@bitgnome.net
Apartment 724                               http://nipsy.bitgnome.net/
Bryan, Texas, 77802-4481           AIM/Yahoo: texasnipsy ICQ: 66971617
(979)575-3193                                      MSN: nipsy@tamu.edu

-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GG/IT d- s++:+ a- C++$ UBL++++$ P--->+++ L+++$ !E---
W++(--) N+ o K++ w(---) O++ M V(--) PS+++(+) PE(--)
Y+ PGP t+ 5 X R tv b+++@ DI+(++) D+ G e h r++ y+(**)
------END GEEK CODE BLOCK------

---begin random quote of the moment---
If you're not part of the solution, you're part of the precipitate.
----end random quote of the moment----
