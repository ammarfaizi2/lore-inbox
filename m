Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbWAQWID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbWAQWID (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 17:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWAQWID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 17:08:03 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:13461 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964861AbWAQWIB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 17:08:01 -0500
Date: Tue, 17 Jan 2006 23:07:49 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Tomasz =?iso-8859-2?Q?K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>,
       Phil Oester <kernel@linuxace.com>, linux-kernel@vger.kernel.org,
       apiszcz@lucidpixels.com
Subject: Re: Kernel 2.6.15.1 + NFS is 4 times slower than FTP!?
In-Reply-To: <Pine.LNX.4.64.0601171545310.19112@p34>
Message-ID: <Pine.LNX.4.61.0601172307030.7756@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0601161957300.16829@p34>  <20060117012319.GA22161@linuxace.com>
  <Pine.LNX.4.64.0601162031220.2501@p34>  <Pine.BSO.4.63.0601171846570.15077@rudy.mif.pg.gda.pl>
  <1137521483.14135.59.camel@localhost.localdomain>  <Pine.LNX.4.64.0601171324010.25508@p34>
  <1137523035.7855.91.camel@lade.trondhjem.org>  <Pine.LNX.4.64.0601171338040.25508@p34>
  <1137523991.7855.103.camel@lade.trondhjem.org>  <Pine.LNX.4.64.0601171354510.25508@p34>
 <1137524502.7855.107.camel@lade.trondhjem.org> <Pine.LNX.4.61.0601172139230.30708@yvahk01.tjqt.qr>
 <Pine.LNX.4.64.0601171545310.19112@p34>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> auto   Can be mounted with the -a option.
>
> defaults
> Use default options: rw, suid, dev, exec,  auto,
> nouser, and async.
>
> The default is async, no?

The server side also needs to specify async in exports. You even get a 
warning if you do not specify sync or async, because the default had 
been changed once.



Jan Engelhardt
-- 
