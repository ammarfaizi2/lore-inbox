Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262625AbSJOF76>; Tue, 15 Oct 2002 01:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262641AbSJOF76>; Tue, 15 Oct 2002 01:59:58 -0400
Received: from packet.digeo.com ([12.110.80.53]:8910 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262625AbSJOF75>;
	Tue, 15 Oct 2002 01:59:57 -0400
Message-ID: <3DABB036.801DA1DA@digeo.com>
Date: Mon, 14 Oct 2002 23:05:42 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matt Reppert <arashi@arashi.yi.org>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       ext2-devel@lists.sourceforge.net, tytso@mit.edu
Subject: Re: [PATCH] Compile without xattrs
References: <3DABA351.7E9C1CFB@digeo.com> <20021015005733.3bbde222.arashi@arashi.yi.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Oct 2002 06:05:43.0120 (UTC) FILETIME=[E5112500:01C27410]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Reppert wrote:
> 
> On Mon, 14 Oct 2002 22:10:41 -0700
> Andrew Morton <akpm@digeo.com> wrote:
> 
> > - merge up the ext2/3 extended attribute code, convert that to use
> >   the slab shrinking API in Linus's current tree.
> 
> Trivial patch for the "too chicken to enable xattrs for now" case, but I
> need this to compile:
> 

Thanks.  I uploaded a copy to
http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.42/2.5.42-mm3/no-xattrs.patch
