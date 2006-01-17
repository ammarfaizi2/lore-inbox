Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbWAQUkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWAQUkP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 15:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbWAQUkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 15:40:14 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:14787 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964836AbWAQUkN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 15:40:13 -0500
Date: Tue, 17 Jan 2006 21:39:53 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Justin Piszcz <jpiszcz@lucidpixels.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Tomasz =?iso-8859-2?Q?K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>,
       Phil Oester <kernel@linuxace.com>, linux-kernel@vger.kernel.org,
       apiszcz@lucidpixels.com
Subject: Re: Kernel 2.6.15.1 + NFS is 4 times slower than FTP!?
In-Reply-To: <1137524502.7855.107.camel@lade.trondhjem.org>
Message-ID: <Pine.LNX.4.61.0601172139230.30708@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0601161957300.16829@p34>  <20060117012319.GA22161@linuxace.com>
  <Pine.LNX.4.64.0601162031220.2501@p34>  <Pine.BSO.4.63.0601171846570.15077@rudy.mif.pg.gda.pl>
  <1137521483.14135.59.camel@localhost.localdomain>  <Pine.LNX.4.64.0601171324010.25508@p34>
  <1137523035.7855.91.camel@lade.trondhjem.org>  <Pine.LNX.4.64.0601171338040.25508@p34>
  <1137523991.7855.103.camel@lade.trondhjem.org>  <Pine.LNX.4.64.0601171354510.25508@p34>
 <1137524502.7855.107.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Did you get my other e-mail?
>> 
>> $ cp file /nfs/destination
>> $ lftp> put file
>
>
>Yes, but how big a file is this? Is it significantly larger than the
>amount of cache memory on the server? As I said, if ftp is failing to
>sync the file to disk, then you may be comparing apples and oranges.


Ok, so what happens if you use NFS with the async option, does it go a 
little faster?



Jan Engelhardt
-- 
