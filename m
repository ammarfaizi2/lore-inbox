Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262358AbSJOFOj>; Tue, 15 Oct 2002 01:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262365AbSJOFOi>; Tue, 15 Oct 2002 01:14:38 -0400
Received: from packet.digeo.com ([12.110.80.53]:26061 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262358AbSJOFOh>;
	Tue, 15 Oct 2002 01:14:37 -0400
Message-ID: <3DABA596.39C9D782@digeo.com>
Date: Mon, 14 Oct 2002 22:20:22 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>,
       ext2-devel@lists.sourceforge.net, "tytso@mit.edu" <tytso@mit.edu>
Subject: Re: 2.5.43-m3
References: <3DABA351.7E9C1CFB@digeo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Oct 2002 05:20:22.0549 (UTC) FILETIME=[8F7AF450:01C2740A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


yeah, yeah.  off-by-one.

Andrew Morton wrote:
> 
> ...
> - Add Ingo's current remap_file_pages() patch.  I had to renumber his
>   syscall from 253 to 254 due to a clash with the oprofile syscall.
> 

This will only work on ia32.  To test on other architectures, please
do a patch -p1 -R of

http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.42/2.5.42-mm3/broken-out/mpopulate.patch
