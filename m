Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWGGONp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWGGONp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 10:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWGGONp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 10:13:45 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60432 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751219AbWGGONo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 10:13:44 -0400
Date: Fri, 7 Jul 2006 14:12:09 +0000
From: Pavel Machek <pavel@ucw.cz>
To: "Jeffrey V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Bill Davidsen <davidsen@tmr.com>,
       Benny Amorsen <benny+usenet@amorsen.dk>, linux-kernel@vger.kernel.org
Subject: Re: ext4 features
Message-ID: <20060707141209.GD4239@ucw.cz>
References: <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no> <20060703205523.GA17122@irc.pl> <1151960503.3108.55.camel@laptopd505.fenrus.org> <44A9904F.7060207@wolfmountaingroup.com> <20060703232547.2d54ab9b.diegocg@gmail.com> <m3r711u3yk.fsf@ursa.amorsen.dk> <44AB3E4C.2000407@tmr.com> <44AB4A68.90301@zytor.com> <44AB5210.50501@wolfmountaingroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44AB5210.50501@wolfmountaingroup.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>Actually, if it were so important it WOULD have been 
> >>done. I suspect that the issue is not lack of a good 
> >>solution, but lack of a good problem. The behavior you 
> >>propose requires a lot of kernel cleverness, including 
> >>make the inodes seem to go away, so the count is 
> >>"right" for what the user sees.
> >>
> >
> >The real solution for it is snapshots.
> 
> 
> Peter,
> 
> Explain what you are thinking here.  What I proposed, I 
> have already implemented in NetWare, it's very easy to 
> do.  Snapshotting is not complex for FS's but does 
> require a lot of space for meta-data to manage it.  EXT 
> is not architecteced for something this complex.  A 
> simple hidden mv is much easier to do.

Patch would be nice :-).

Hidden mv is indeed simple; reclaiming space on demand may be
trickier.
							Pavel
-- 
Thanks for all the (sleeping) penguins.
