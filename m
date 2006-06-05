Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750748AbWFEW5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWFEW5Y (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 18:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWFEW5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 18:57:24 -0400
Received: from hera.kernel.org ([140.211.167.34]:48096 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750748AbWFEW5X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 18:57:23 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: squashfs size in statfs
Date: Mon, 5 Jun 2006 15:57:13 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e62cs9$csl$1@terminus.zytor.com>
References: <Pine.LNX.4.61.0606051243100.579@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1149548233 13206 127.0.0.1 (5 Jun 2006 22:57:13 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 5 Jun 2006 22:57:13 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.61.0606051243100.579@yvahk01.tjqt.qr>
By author:    Jan Engelhardt <jengelh@linux01.gwdg.de>
In newsgroup: linux.dev.kernel
>
> Hello list,
> 
> 
> # l /mnt
> total 36293
> drwxr-xr-x   2 root root       20 Jun  5 11:50 .
> drwxr-xr-x  31 root root     4096 Jun  5  2006 ..
> -rw-r--r--   1 root root 37158912 Jun  5 11:06 mem
> # df
> Filesystem           1K-blocks      Used Available Use% Mounted on
> /dev/shm/sc.sqfs         26688     26688         0 100% /mnt
> # l sc.sqfs
> -rwx------  1 jengelh users 27279360 Jun  5 11:50 sc.sqfs
> 
> I think statfs() should show the uncompressed size, no?
> 

No.

	-hpa
