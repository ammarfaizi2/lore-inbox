Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316446AbSEZVpf>; Sun, 26 May 2002 17:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316449AbSEZVpe>; Sun, 26 May 2002 17:45:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30993 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316446AbSEZVpe>;
	Sun, 26 May 2002 17:45:34 -0400
Message-ID: <3CF15838.FE768070@zip.com.au>
Date: Sun, 26 May 2002 14:48:40 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Peter J. Braam" <braam@clusterfs.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [patch 11/18] dirsync
In-Reply-To: <3CF14973.B61EF771@zip.com.au> <20020526093637.V32110@lustre.cfs>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Peter J. Braam" wrote:
> 
> Hi
> 
> I think this patch is actually pretty important - could we please have
> this, or something like this?
> 

Well `-o sync' will give the same result.  dirsync is just a speedup.

I should have mentioned: untarring a kernel tree with dirsync is 4x to
5x faster than `-o sync', but still tons slower (5x?) than default.
