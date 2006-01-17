Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbWAQWN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWAQWN5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 17:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbWAQWN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 17:13:57 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:12231 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964778AbWAQWN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 17:13:56 -0500
Subject: Re: Kernel 2.6.15.1 + NFS is 4 times slower than FTP!?
From: Lee Revell <rlrevell@joe-job.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Tomasz =?iso-8859-2?Q?K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>,
       Phil Oester <kernel@linuxace.com>, linux-kernel@vger.kernel.org,
       apiszcz@lucidpixels.com
In-Reply-To: <Pine.LNX.4.61.0601172307030.7756@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0601161957300.16829@p34>
	 <20060117012319.GA22161@linuxace.com>
	 <Pine.LNX.4.64.0601162031220.2501@p34>
	 <Pine.BSO.4.63.0601171846570.15077@rudy.mif.pg.gda.pl>
	 <1137521483.14135.59.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0601171324010.25508@p34>
	 <1137523035.7855.91.camel@lade.trondhjem.org>
	 <Pine.LNX.4.64.0601171338040.25508@p34>
	 <1137523991.7855.103.camel@lade.trondhjem.org>
	 <Pine.LNX.4.64.0601171354510.25508@p34>
	 <1137524502.7855.107.camel@lade.trondhjem.org>
	 <Pine.LNX.4.61.0601172139230.30708@yvahk01.tjqt.qr>
	 <Pine.LNX.4.64.0601171545310.19112@p34>
	 <Pine.LNX.4.61.0601172307030.7756@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Tue, 17 Jan 2006 17:13:53 -0500
Message-Id: <1137536034.19678.43.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-17 at 23:07 +0100, Jan Engelhardt wrote:
> > auto   Can be mounted with the -a option.
> >
> > defaults
> > Use default options: rw, suid, dev, exec,  auto,
> > nouser, and async.
> >
> > The default is async, no?
> 
> The server side also needs to specify async in exports. You even get a 
> warning if you do not specify sync or async, because the default had 
> been changed once.
> 

What is the date on the above man page?  Looks like the docs need to be
updated.

I believe the default was originally async, which violates the NFS spec
and is dangerous, and changed to sync at some point.

Lee

