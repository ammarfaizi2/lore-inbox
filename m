Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314362AbSE0GNy>; Mon, 27 May 2002 02:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314379AbSE0GNx>; Mon, 27 May 2002 02:13:53 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:59342 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S314362AbSE0GNx>;
	Mon, 27 May 2002 02:13:53 -0400
Date: Mon, 27 May 2002 16:13:46 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] consolidate errno definitions
Message-Id: <20020527161346.6ce3bde0.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just remove duplicates among the asm-*/errno.h.

see <http://www.canb.auug.org.au/~sfr/18-errno.1.diff.gz>

Please have a look and comment.

I assume the differences are due to ABI requirements, if not
then more consolidation is probably possible.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
