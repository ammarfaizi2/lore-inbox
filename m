Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751551AbWIUUmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbWIUUmw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 16:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbWIUUmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 16:42:52 -0400
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:51870 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1750834AbWIUUmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 16:42:51 -0400
Date: Thu, 21 Sep 2006 16:42:50 -0400
To: Dax Kelson <dax@gurulabs.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Smaller compressed kernel source tarballs?
Message-ID: <20060921204250.GN13641@csclub.uwaterloo.ca>
References: <1158870777.24172.23.camel@mentorng.gurulabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158870777.24172.23.camel@mentorng.gurulabs.com>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2006 at 02:32:57PM -0600, Dax Kelson wrote:
> Today as I was watching the linux-2.6.18.tar.bz2 slowly download I
> thought it would be nice if it could be made smaller.
> 
> The 7zip program/algorithm is free software (LGPL) and can be obtained
> from http://www.7-zip.org/ and it is distributed with several
> distributions (it is in Fedora Core 6 extras for example).
> 
> Here are the numbers:
> 
> ls -al
> -rw-r--r--  1 root root 240138240 Sep 21 13:55 linux-2.6.18.tar
> -rw-r--r--  1 root root  34180796 Sep 21 13:42 linux-2.6.18.tar.7z
> -rw-r--r--  1 root root  41863580 Sep 21 13:45 linux-2.6.18.tar.bz2
> -rw-r--r--  1 root root  52467357 Sep 21 13:13 linux-2.6.18.tar.gz
> 
> ls -alh
> -rw-r--r--  1 root root 230M Sep 21 13:55 linux-2.6.18.tar
> -rw-r--r--  1 root root  33M Sep 21 13:42 linux-2.6.18.tar.7z
> -rw-r--r--  1 root root  40M Sep 21 13:45 linux-2.6.18.tar.bz2
> -rw-r--r--  1 root root  51M Sep 21 13:13 linux-2.6.18.tar.gz
> 
> Smaller the better, especially with the international audience.

But after you download it once, you can just get the diff next time.
How is the decompression time on 7zip versus bzip2 and gzip?

--
Len Sorensen
