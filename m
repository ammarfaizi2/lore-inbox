Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWAVIOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWAVIOL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 03:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWAVIOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 03:14:11 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51329 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932110AbWAVIOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 03:14:10 -0500
Subject: Re: [2.6 patch] the scheduled removal of the obsolete raw driver
From: Arjan van de Ven <arjan@infradead.org>
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200601211909.15559.gene.heskett@verizon.net>
References: <20060119030251.GG19398@stusta.de>
	 <200601211853.56339.gene.heskett@verizon.net>
	 <87bqy5m8u3.fsf@asmodeus.mcnaught.org>
	 <200601211909.15559.gene.heskett@verizon.net>
Content-Type: text/plain
Date: Sun, 22 Jan 2006 09:14:06 +0100
Message-Id: <1137917647.3328.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-21 at 19:09 -0500, Gene Heskett wrote:
> On Saturday 21 January 2006 18:59, Doug McNaught wrote:
> >Gene Heskett <gene.heskett@verizon.net> writes:
> >>>No, it's a different raw driver, for big databases that basically
> >>> want their own custom filesystem on a disk.
> >>
> >> With the attendent possibility of rendering the whole thing
> >> unrecoverably moot?
> >>
> >> OTOH, if this database actually does have a better way, and its
> >> mature and proven, then I see no reason to cripple the database
> >> people just to remove what is viewed as a potentially dangerous path
> >> to the media surface for the unwashed to abuse.
> >
> >The database people have a newer and supported way to do that, via the
> >O_DIRECT flag to open().  They aren't losing any functionality.
> >
> Good, but what about speed, is that impacted in any way they can 
> measure, or is this flag/method actually faster than the raw driver is?

the 2.6 raw driver is just a wrapper layer around this O_DIRECT open.


