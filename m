Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129667AbRCAP4D>; Thu, 1 Mar 2001 10:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129669AbRCAPzn>; Thu, 1 Mar 2001 10:55:43 -0500
Received: from mgw-x2.nokia.com ([131.228.20.22]:22999 "EHLO mgw-x2.nokia.com")
	by vger.kernel.org with ESMTP id <S129667AbRCAPzd>;
	Thu, 1 Mar 2001 10:55:33 -0500
Date: Thu, 1 Mar 2001 15:30:56 +0200 (EET)
From: "Matilainen Panu (NRC/Helsinki)" <panu.matilainen@nokia.com>
To: ext Andrew Morton <andrewm@uow.edu.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.x very unstable on 8-way IBM 8500R
In-Reply-To: <3A9E3F00.E5667AAC@uow.edu.au>
Message-ID: <Pine.LNX.4.30.0103011523200.23756-100000@godzilla.research.nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2001, ext Andrew Morton wrote:
> "Matilainen Panu (NRC/Helsinki)" wrote:
> > On Thu, 1 Mar 2001, ext Andrew Morton wrote:
> > >
> > > Is it stable with `nmi_watchdog=0'?
> >
> > If the default value for nmi_watchdog is 0 then no - I added the
> > nmi_watchdog=1 just to see if that makes any difference. If it's on by
> > default then I'll need to test it that way.
>
> Default for nmi_watchdog is `enabled'.
>
> Several people have reported that turning it off with
> the `nmi_watchdog=0' LILO option makes systems stable.
> Nobody knows why.
>
> (If nmi_watchdog _does_ make the achine stable, please
>  tell linux-kernel.).

It's too early to say for sure but that seems to have fixed it. Uptime now
nearly an hour under loads of 20-30 which is way more than it has been
able to stay up before. I'll let you know whether its still up tomorrow.

Million thanks for the tip!

	- Panu -

>

-- 



