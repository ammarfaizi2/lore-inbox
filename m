Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277686AbRJRKVQ>; Thu, 18 Oct 2001 06:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277695AbRJRKVG>; Thu, 18 Oct 2001 06:21:06 -0400
Received: from mail.science.uva.nl ([146.50.4.51]:17909 "EHLO
	mail.science.uva.nl") by vger.kernel.org with ESMTP
	id <S277686AbRJRKUq>; Thu, 18 Oct 2001 06:20:46 -0400
X-Organisation: Faculty of Science, University of Amsterdam, The Netherlands
X-URL: http://www.science.uva.nl/
Date: Thu, 18 Oct 2001 12:11:35 +0200 (CEST)
From: Kamil Iskra <kamil@science.uva.nl>
To: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
cc: kernel <linux-kernel@vger.kernel.org>
Subject: Re: Poor floppy performance in kernel 2.4.10
In-Reply-To: <20011017204524.88702.qmail@web10404.mail.yahoo.com>
Message-ID: <Pine.LNX.4.33.0110181158060.6306-100000@krakow.science.uva.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2001, [iso-8859-1] Steve Kieu wrote:

> Negative here, I am using 2.4.12-ac2 here and did not
> notice what you said,

Well, perhaps the ac series does not suffer from this problem?  As I
stated in the original mail, I'm using 2.4.12 (from Linus).

> the speed of transfer is still
> about 23KB/sec when copying a 1.1Mb file from floppy ;
> it is the same as before, even better :-)

I just measured it for a file of that size, and I even got 29KB/sec.

However, it's performance for small files, directory listing operations
etc. that I'm complaining about.  And not for a mounted floppy (which
seems to be fine), but when using mtools.

So, to reiterate, the conditions known to be necessary to reproduce it
are: kernel >=2.4.10 (perhaps only the Linus series), small files or
directory operations, mtools.  The behaviour is as if no caching was done,
there is a slowdown by a factor of two.  I have this problem both on my
laptop and on the desktop machine at work.  They are running different
kernel versions (2.4.12 and 2.4.10), differently configured and compiled
by two different people.  Kernel 2.4.9 and earlier worked fine.

Regards,

-- 
Kamil Iskra                 http://www.science.uva.nl/~kamil/
Section Computational Science, Faculty of Science, Universiteit van Amsterdam
kamil@science.uva.nl  tel. +31 20 525 75 35  fax. +31 20 525 74 90
Kruislaan 403  room F.202  1098 SJ Amsterdam  The Netherlands

