Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266137AbUF2XTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266137AbUF2XTt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 19:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266138AbUF2XTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 19:19:49 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:59142 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S266137AbUF2XTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 19:19:48 -0400
Message-ID: <40E1FDEC.6020606@techsource.com>
Date: Tue, 29 Jun 2004 19:40:28 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Markus Schaber <schabios@logi-track.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Block Device Caching
References: <20040630002014.4970b82d@kingfisher.intern.logi-track.com>
In-Reply-To: <20040630002014.4970b82d@kingfisher.intern.logi-track.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Markus Schaber wrote:

> This lead us to the conclusion that block devices do not cache, but the
> filesystem does. But subsequently, I ran some tests on my developer
> machine (Pentium 4 Mobile Laptop).


I had kernel experts repeatedly insist to me that block devices were 
cached, while all of my tests (using dd to or from, say, /dev/sda1 or 
whatever) indicated that there was absolutely no caching whatsoever.

In my experience, reads and writes to block devices are uncached, while 
filesystem stuff IS cached.

