Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315921AbSETLkj>; Mon, 20 May 2002 07:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315922AbSETLki>; Mon, 20 May 2002 07:40:38 -0400
Received: from [202.149.212.34] ([202.149.212.34]:38757 "EHLO cmie.com")
	by vger.kernel.org with ESMTP id <S315921AbSETLkh>;
	Mon, 20 May 2002 07:40:37 -0400
Date: Mon, 20 May 2002 17:10:23 +0530 (IST)
From: Ganajyoti Bhattacherjee <bgana@cmie.com>
X-X-Sender: <bgana@saturn.cmie.ernet.in>
To: <linux-kernel@vger.kernel.org>
Subject: Data Corruption with Dump
Message-ID: <Pine.LNX.4.33.0205201708170.3638-100000@saturn.cmie.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just happenned to read Linus'opinion on using dump for backup (in a
mail
from him to linux-kernel mailing list on 27 Apr 2001). He wrote

-------------------------------------------------------------------------
"...Note that dump simply won't work reliably at all even in 2.4.x: the
buffer cache and the page cache (where all the actual data is) are not
coherent. This is only going to get even worse in 2.5.x, when the
directories are moved into the page cache as well.

So anybody who depends on "dump" getting backups right is already playing
russian rulette with their backups.  It's not at all guaranteed to get the
right results - you may end up having stale data in the buffer cache that
ends up being "backed up"......"
---------------------------------------------------------------------------

But is the above true even in case of taking "dump" of an unmounted
filesystem.
I am using SuSE 7.3 (kernel-2.4.18-SMP).

Thanx

--Gana
(G. Bhattacherjee)


