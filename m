Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314080AbSE0GB2>; Mon, 27 May 2002 02:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314291AbSE0GB0>; Mon, 27 May 2002 02:01:26 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:51405 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S314080AbSE0GB0>;
	Mon, 27 May 2002 02:01:26 -0400
Date: Mon, 27 May 2002 16:01:20 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] consolidate generic peices of the siginfo structures and associated stuff
Message-Id: <20020527160120.3b9bbe5d.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch creates asm-generic/siginfo.h and uses it to remove a
lot of duplicate code in the various asm-*/siginfo.h files.  Some
if it is a little ugly, but I think it will be worth it just to
help us eliminate some of the bugs that have come from code copying.

see <http://www.canb.auug.org.au/~sfr/18-si.1.diff.gz>

[URL because it is ~120k patch]

Please have a look and comment.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
