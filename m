Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267494AbUHJPgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267494AbUHJPgp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 11:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267475AbUHJPgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 11:36:44 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:2758 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267431AbUHJPeT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 11:34:19 -0400
Date: Tue, 10 Aug 2004 17:33:34 +0200
From: Jens Axboe <axboe@suse.de>
To: Stephan von Krawczynski <skraw@ithnet.com>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       alan@lxorguk.ukuu.org.uk, diablod3@gmail.com, dwmw2@infradead.org,
       eric@lammerts.org, james.bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040810153333.GF13369@suse.de>
References: <200408101427.i7AERDld014134@burner.fokus.fraunhofer.de> <20040810164947.7f363529.skraw@ithnet.com> <20040810152458.GA1127@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040810152458.GA1127@lug-owl.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10 2004, Jan-Benedict Glaw wrote:
> On Tue, 2004-08-10 16:49:47 +0200, Stephan von Krawczynski <skraw@ithnet.com>
> wrote in message <20040810164947.7f363529.skraw@ithnet.com>:
> > On Tue, 10 Aug 2004 16:27:13 +0200 (CEST)
> > Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> > > 
> > > -	These distributions do not talk with the original Authors which
> > > 	demonstrates that they do not like to benefit from OSS.
> > 
> > Really, have you listened to yourself lately: "Commercial distros do not like
> > to benefit from OSS." ??? 
> > How do you define their primary goal, arguing with Joerg Schilling, or what?
> 
> IIRC Jörg complained some hundred emails ago that they (the SuSE
> people) don't care to try to get their patches upstream, back to Jörg,
> or discussing their changes with him (but instead hacking cdrecord the
> way it fits best for them).

Don't be naive. How do you discuss changes with him? The one patch I did
create against the SUSE cdrecord for the one shipped with SL9.1 adds a
note to use ATA over ATAPI since that is preferred, and it kills the
silly open-by-devname warnings that are extremely confusing to users. I
did send that back to Joerg, to no avail.

> While they (and any other distro's people and anybody else) may
> actually hack the code to no end, I consider it being good habit to

By far the largest modification is dvd support, which we of course need
to ship. The rest is really minor stuff.

-- 
Jens Axboe

