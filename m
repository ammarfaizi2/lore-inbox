Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261224AbSJYJ22>; Fri, 25 Oct 2002 05:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261325AbSJYJ22>; Fri, 25 Oct 2002 05:28:28 -0400
Received: from cs146114.pp.htv.fi ([213.243.146.114]:44300 "EHLO chip.ath.cx")
	by vger.kernel.org with ESMTP id <S261224AbSJYJ21>;
	Fri, 25 Oct 2002 05:28:27 -0400
Date: Fri, 25 Oct 2002 12:34:20 +0300 (EEST)
From: Panu Matilainen <pmatilai@welho.com>
X-X-Sender: pmatilai@chip.ath.cx
To: Tim Hockin <thockin@sun.com>
cc: Jesse Pollard <pollard@admin.navo.hpc.mil>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 1/4] fix NGROUPS hard limit (resend)
In-Reply-To: <3DB59722.2090701@sun.com>
Message-ID: <Pine.LNX.4.44.0210251233030.23877-100000@chip.ath.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2002, Tim Hockin wrote:

> Jesse Pollard wrote:
> 
> > Does it actually work with NFS???? or any networked file system?
> > Most of them limit ngroups to 16 to 32, and cannot send any data
> > if there is an overflow, since that overflow would replace all of the
> > data you try to send/recieve...
> 
> NFS has a smaller limit, that is correct.  An unfortunate limitation.
> 
> > And I really doubt that anybody has 10000 unique groups (or even
> > close to that) running under any system. The center I'm at has
> > some of the largest UNIX systems ever made, and there are only
> > about 600 unique groups over the entire center. The largest number
> > of groups a user can be in is 32. And nobody even comes close.
> 
> I'm glad it doesn't affect you.  If it was a more common problem, it 
> would have been solved a long time ago.  It does affect some people, 
> though.  Maybe they can redesign their group structures, but why not 
> remove this arbitrary limit, since we can?

This is a real, if not terribly common problem here too. Thanks for 
addressing the issue...

-- 
	- Panu -

