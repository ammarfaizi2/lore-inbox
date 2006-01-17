Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbWAQXTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbWAQXTm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 18:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964895AbWAQXTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 18:19:41 -0500
Received: from lucidpixels.com ([66.45.37.187]:53943 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S964891AbWAQXTl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 18:19:41 -0500
Date: Tue, 17 Jan 2006 18:19:39 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Lee Revell <rlrevell@joe-job.com>
cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Tomasz =?iso-8859-2?Q?K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>,
       Phil Oester <kernel@linuxace.com>, linux-kernel@vger.kernel.org,
       apiszcz@lucidpixels.com
Subject: Re: Kernel 2.6.15.1 + NFS is 4 times slower than FTP!?
In-Reply-To: <1137536034.19678.43.camel@mindpipe>
Message-ID: <Pine.LNX.4.64.0601171819370.30825@p34>
References: <Pine.LNX.4.64.0601161957300.16829@p34>  <20060117012319.GA22161@linuxace.com>
  <Pine.LNX.4.64.0601162031220.2501@p34>  <Pine.BSO.4.63.0601171846570.15077@rudy.mif.pg.gda.pl>
  <1137521483.14135.59.camel@localhost.localdomain>  <Pine.LNX.4.64.0601171324010.25508@p34>
  <1137523035.7855.91.camel@lade.trondhjem.org>  <Pine.LNX.4.64.0601171338040.25508@p34>
  <1137523991.7855.103.camel@lade.trondhjem.org>  <Pine.LNX.4.64.0601171354510.25508@p34>
  <1137524502.7855.107.camel@lade.trondhjem.org> 
 <Pine.LNX.4.61.0601172139230.30708@yvahk01.tjqt.qr>  <Pine.LNX.4.64.0601171545310.19112@p34>
  <Pine.LNX.4.61.0601172307030.7756@yvahk01.tjqt.qr> <1137536034.19678.43.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

man mount

On Tue, 17 Jan 2006, Lee Revell wrote:

> On Tue, 2006-01-17 at 23:07 +0100, Jan Engelhardt wrote:
>>> auto   Can be mounted with the -a option.
>>>
>>> defaults
>>> Use default options: rw, suid, dev, exec,  auto,
>>> nouser, and async.
>>>
>>> The default is async, no?
>>
>> The server side also needs to specify async in exports. You even get a
>> warning if you do not specify sync or async, because the default had
>> been changed once.
>>
>
> What is the date on the above man page?  Looks like the docs need to be
> updated.
>
> I believe the default was originally async, which violates the NFS spec
> and is dangerous, and changed to sync at some point.
>
> Lee
>
