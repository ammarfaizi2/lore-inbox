Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932532AbVL1Q2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbVL1Q2D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 11:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932534AbVL1Q2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 11:28:03 -0500
Received: from xenotime.net ([66.160.160.81]:31970 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932532AbVL1Q2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 11:28:01 -0500
Date: Wed, 28 Dec 2005 08:28:00 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Mathias Klein <ma_klein@gmx.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: oops in kernel 2.6.15-rc6
In-Reply-To: <20051228145502.GB9777@sidney>
Message-ID: <Pine.LNX.4.58.0512280827150.5278@shark.he.net>
References: <20051228135021.GA9777@sidney> <43B2A122.7030203@thinrope.net>
 <20051228145502.GB9777@sidney>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Dec 2005, Mathias Klein wrote:

> On Wed, Dec 28, 2005 at 11:28:50PM +0900, Kalin KOZHUHAROV wrote:
> > Mathias Klein wrote:
> > > Hello all,
> > >
> > > [please CC me on replies, I'm not subscribed to this list]
> > >
> > > I had this following kernel oops while compiling a new kernel.
> > >
> > > Dec 27 19:02:00 sidney kernel: [14896.995613] Unable to handle kernel paging request at virtual address 76f7104d
> > > Dec 27 19:02:00 sidney kernel: [14896.995665]  printing eip:
> > > Dec 27 19:02:00 sidney kernel: [14896.995682] c013a392
> > > Dec 27 19:02:00 sidney kernel: [14896.995692] *pde = 00000000
> > > Dec 27 19:02:00 sidney kernel: [14896.995711] Oops: 0002 [#1]
> >
> > I might be wrong, but that is the second oops for this run, probably the first [#0] is more
> > interesting...
>
> Probably yes but there is no [#0] Oops in the logs.
> (Indeed I do have another [#1] Oops in another run with that kernel without
> an [#0] Oops)

The first Oops is #1.
That is the one that we are interested in most of the time.

-- 
~Randy
