Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264920AbTBCIpg>; Mon, 3 Feb 2003 03:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265305AbTBCIpg>; Mon, 3 Feb 2003 03:45:36 -0500
Received: from mail.zmailer.org ([62.240.94.4]:24711 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S264920AbTBCIpf>;
	Mon, 3 Feb 2003 03:45:35 -0500
Date: Mon, 3 Feb 2003 10:55:04 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH *] use 64 bit jiffies
Message-ID: <20030203085504.GU821@mea-ext.zmailer.org>
References: <20030203082800.GT821@mea-ext.zmailer.org> <Pine.LNX.4.33.0302030943590.26414-100000@gans.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0302030943590.26414-100000@gans.physik3.uni-rostock.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2003 at 09:47:00AM +0100, Tim Schmielau wrote:
> On Mon, 3 Feb 2003, Matti Aarnio wrote:
> > I do have a number of machines with 100 to 300 day uptimes, all
> > with "mere" 32-bit jiffy.  With 1000 Hz clock that means at least
> > one full wrap-around of jiffy.
> 
> Are these 2.5 machines? If so I'd really like to know whether or not
> ps shows old processes as having started in the future.
> With a simulated uptime it does, but I might have overlooked something.

300 day uptime with 2.5 ?  Do think again.

These are 2.4 series kernels.  2.4.17, 2.4.18, 2.4.20

With updated 'ps' tools the processes are definitely in the past,
although seeing mere "2002" does not tell all that detailed about
"when".  A "apr17" would be more usefull.  Any date in "future"
means it is of previous year.

> Tim

/Matti Aarnio
