Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135560AbRDST6t>; Thu, 19 Apr 2001 15:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135364AbRDST6i>; Thu, 19 Apr 2001 15:58:38 -0400
Received: from ns.caldera.de ([212.34.180.1]:33545 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S135551AbRDST5v>;
	Thu, 19 Apr 2001 15:57:51 -0400
Date: Thu, 19 Apr 2001 21:55:57 +0200
From: Christoph Hellwig <hch@ns.caldera.de>
To: linux-lvm@sistina.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jes Sorensen <jes@linuxcare.com>,
        linux-kernel@vger.kernel.org, linux-openlvm@nl.linux.org,
        Arjan van de Ven <arjanv@redhat.com>, Jens Axboe <axboe@suse.de>,
        Martin Kasper Petersen <mkp@linuxcare.com>, riel@conectiva.com.br
Subject: Re: [linux-lvm] Re: [repost] Announce: Linux-OpenLVM mailing list
Message-ID: <20010419215557.A7477@caldera.de>
Mail-Followup-To: linux-lvm@sistina.com,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Jes Sorensen <jes@linuxcare.com>, linux-kernel@vger.kernel.org,
	linux-openlvm@nl.linux.org, Arjan van de Ven <arjanv@redhat.com>,
	Jens Axboe <axboe@suse.de>,
	Martin Kasper Petersen <mkp@linuxcare.com>, riel@conectiva.com.br
In-Reply-To: <20010419142400.E10345@sistina.com> <200104191945.f3JJjKRn015661@webber.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <200104191945.f3JJjKRn015661@webber.adilger.int>; from adilger@turbolinux.com on Thu, Apr 19, 2001 at 01:45:20PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2001 at 01:45:20PM -0600, Andreas Dilger wrote:
> I don't think that the subscription is necessarily the only issue.  I'm
> subscribed to all of the LVM mailing lists, and still a lot of what I
> submit (legitimate bug fixes, and not just features/code cleanup) does
> not get added to CVS.

Just alone the fact that you as number one submitter of LVM-bugfixes since
at least 0.8 do not get CVS write access is a sign of closedness for me.

But we discussed that on the sistina list.

> Yes, the no-possible-harm patches like man pages
> went in, but not other stuff.  Also, it doesn't appear that any of the
> LVM changes are making it into the stock kernel, which is basically a
> recepie for disaster.

100% True.  A few days ago I looke at the LVM patches to see what parts
of it could be fed to Linus in small pieces - but it's such a _huge_
mixture of bugfixes, cleanups and move-arounds that it looks pretty
much impossible.

> Basically, I'm at the point where trying to create clean patches from my
> LVM source tree to apply to CVS is so much work it is hardly worth it.

IMHO wou should just put _your_ tree on a sever and submit it (in pieces)
to Linus.  AFAIK all serious users of LVM have used you're patched versions.

Maybe openlvm is a good hood for such a project?

> I'm seriously looking at devoting the time I used to spend on LVM to the
> EVMS project instead.  They (appear to) have in-kernel LVM support working
> already, so no user tools needed for VG/LV activation.  Granted, they don't
> yet have tools to create/modify VG/LVs, but I think I can help them there.

Yes - when looking at what code they produces it looks a _lot_ cleaner than
Linux-LVM and while the papers had serious signs of Overengeering the
actual code looks very good to me - it could just get a little better
integrated with the main kernel, but that's a 2.5 issue.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
