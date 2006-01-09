Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbWAIQjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbWAIQjk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 11:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWAIQjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 11:39:40 -0500
Received: from xenotime.net ([66.160.160.81]:43685 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932437AbWAIQjj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 11:39:39 -0500
Date: Mon, 9 Jan 2006 08:39:39 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, gcoady@gmail.com, vherva@vianova.fi,
       linux-kernel@vger.kernel.org
Subject: Re: oops pauser.
In-Reply-To: <Pine.LNX.4.61.0601091714330.26210@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.58.0601090838490.952@shark.he.net>
References: <20060105045212.GA15789@redhat.com> <Pine.LNX.4.61.0601050907510.10161@yvahk01.tjqt.qr>
 <20060105103339.GG20809@redhat.com> <20060108133822.GD31624@vianova.fi>
 <20060108055322.18d4236e.rdunlap@xenotime.net> <6cq2s1d3glnj56pcrqlj84s8ltilmo6jfp@4ax.com>
 <20060108174505.6c9b7566.rdunlap@xenotime.net> <Pine.LNX.4.61.0601091714330.26210@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2006, Jan Engelhardt wrote:

> >> So would it be viable to take over the screen in similar fashion?
> >>
> >> Set it to 80x50 in BIOS and dump there --> call it the Penguin Oops
> >> screen, or Poops for short :o)
> >
> >It does take over the screen.  80x50 isn't needed since it knows how
> >to scroll the kernel log buffer on 80x25.
>
> It's needed because scrolling back might be impossible (shift-up in panic
> = no-go), not because it knows how to scroll.

Oh, I see.  You are talking about the kernel message(s), not
kmsgdump.  Sorry, I switched to kmsgdump there somehow.
Yes, more info on the screen from the kernel would be good.

-- 
~Randy
