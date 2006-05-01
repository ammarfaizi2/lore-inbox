Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbWEAWXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWEAWXM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 18:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbWEAWXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 18:23:12 -0400
Received: from quechua.inka.de ([193.197.184.2]:5517 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S932303AbWEAWXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 18:23:11 -0400
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT, ext3fs, kernel 2.4.32... again
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20060502072808.A1873249@wobbly.melbourne.sgi.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1FagnL-0003QN-00@calista.inka.de>
Date: Tue, 02 May 2006 00:23:07 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Scott <nathans@sgi.com> wrote:
>> > Your interpretation is correct. It would be nicer for open() to
>> > fail on fs'es which don't support O_DIRECT, but v2.4 makes such
>> > check later at read/write unfortunately ;(
>> 
>>     Oops :(
> 
> Nothing else really make sense due to fcntl...
>        fcntl(fd, F_SETFL, O_DIRECT);
> ...can happen at any time, to enable/disable direct I/O.

Actually everytime the O_DIRECT feaure is enabled (open() or fctnl()) you
could fail, why not? 

Gruss
Bernd
