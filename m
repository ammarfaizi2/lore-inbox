Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317643AbSFRWWJ>; Tue, 18 Jun 2002 18:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317650AbSFRWWI>; Tue, 18 Jun 2002 18:22:08 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:52385 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317643AbSFRWVh>;
	Tue, 18 Jun 2002 18:21:37 -0400
Date: Tue, 18 Jun 2002 18:21:36 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Frank Davis <fdavis@si.rr.com>
cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.22 : fs/intermezzo/vfs.c
In-Reply-To: <Pine.LNX.4.44.0206181405200.1977-100000@localhost.localdomain>
Message-ID: <Pine.GSO.4.21.0206181819440.13571-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Jun 2002, Frank Davis wrote:

> Hello all,
>   The following patch addresses a name change (i_zombie --> i_sem) within 
> struct inode, which affects fs/intermezzo/vfs.c Please review for 
> inclusion.

	It's much more than a name change.  _Please_, read through the
Documentation/filesystems/porting before playing with that stuff - for
one thing, the entire locking scheme had been changed and fixing
Intermezzo involves a lot more than getting it to compile.


