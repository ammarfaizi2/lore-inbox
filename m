Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbWAQUqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWAQUqA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 15:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbWAQUp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 15:45:59 -0500
Received: from lucidpixels.com ([66.45.37.187]:23941 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S932435AbWAQUp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 15:45:58 -0500
Date: Tue, 17 Jan 2006 15:45:57 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Tomasz =?iso-8859-2?Q?K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>,
       Phil Oester <kernel@linuxace.com>, linux-kernel@vger.kernel.org,
       apiszcz@lucidpixels.com
Subject: Re: Kernel 2.6.15.1 + NFS is 4 times slower than FTP!?
In-Reply-To: <Pine.LNX.4.61.0601172139230.30708@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.64.0601171545310.19112@p34>
References: <Pine.LNX.4.64.0601161957300.16829@p34>  <20060117012319.GA22161@linuxace.com>
  <Pine.LNX.4.64.0601162031220.2501@p34>  <Pine.BSO.4.63.0601171846570.15077@rudy.mif.pg.gda.pl>
  <1137521483.14135.59.camel@localhost.localdomain>  <Pine.LNX.4.64.0601171324010.25508@p34>
  <1137523035.7855.91.camel@lade.trondhjem.org>  <Pine.LNX.4.64.0601171338040.25508@p34>
  <1137523991.7855.103.camel@lade.trondhjem.org>  <Pine.LNX.4.64.0601171354510.25508@p34>
 <1137524502.7855.107.camel@lade.trondhjem.org> <Pine.LNX.4.61.0601172139230.30708@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

               auto   Can be mounted with the -a option.

               defaults
                      Use default options: rw, suid, dev, exec,  auto,
                      nouser, and async.

The default is async, no?

On Tue, 17 Jan 2006, Jan Engelhardt wrote:

>>> Did you get my other e-mail?
>>>
>>> $ cp file /nfs/destination
>>> $ lftp> put file
>>
>>
>> Yes, but how big a file is this? Is it significantly larger than the
>> amount of cache memory on the server? As I said, if ftp is failing to
>> sync the file to disk, then you may be comparing apples and oranges.
>
>
> Ok, so what happens if you use NFS with the async option, does it go a
> little faster?
>
>
>
> Jan Engelhardt
> -- 
>
