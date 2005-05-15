Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbVEOOwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbVEOOwn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 10:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbVEOOwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 10:52:42 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:38410 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261647AbVEOOwk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 10:52:40 -0400
Date: Sun, 15 May 2005 16:52:42 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Hyper-Threading Vulnerability
Message-ID: <20050515145241.GA5627@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <1115963481.1723.3.camel@alderaan.trey.hu> <m164xnatpt.fsf@muc.de> <20050513211609.75216bf8.diegocg@gmail.com> <20050515095446.GE68736@muc.de> <Pine.LNX.4.58.0505151550160.8633@artax.karlin.mff.cuni.cz> <20050515141207.GB94354@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050515141207.GB94354@muc.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2005 at 04:12:07PM +0200, Andi Kleen wrote:
> > > > However they've patched the FreeBSD kernel to "workaround?" it:
> > > > ftp://ftp.freebsd.org/pub/FreeBSD/CERT/patches/SA-05:09/htt5.patch
> > >
> > > That's a similar stupid idea as they did with the disk write
> > > cache (lowering the MTBFs of their disks by considerable factors,
> > > which is much worse than the power off data loss problem)
> > > Let's not go down this path please.
> > 
> > What wrong did they do with disk write cache?
> 
> They turned it off by default, which according to disk vendors
> lowers the MTBF of your disk to a fraction of the original value.
> 
> I bet the total amount of valuable data lost for FreeBSD users because
> of broken disks is much much bigger than what they gained from not losing
> in the rather hard to hit power off cases.

 Aren't I/O barriers a way to safely use write cache?

-- 
Tomasz Torcz                 "God, root, what's the difference?"
zdzichu@irc.-nie.spam-.pl         "God is more forgiving."

