Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273385AbRJPHgc>; Tue, 16 Oct 2001 03:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273463AbRJPHgW>; Tue, 16 Oct 2001 03:36:22 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:2632 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S273385AbRJPHgM>; Tue, 16 Oct 2001 03:36:12 -0400
Message-ID: <3BCBE29D.CFEC1F05@alacritech.com>
Date: Tue, 16 Oct 2001 00:32:45 -0700
From: "Matt D. Robinson" <yakker@alacritech.com>
Organization: Alacritech, Inc.
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Cristiano Paris <c.paris@libero.it>, linux-kernel@vger.kernel.org
Subject: Re: libz, libbz2, ramfs and cramfs
In-Reply-To: <19978.1003206943@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> On Mon, 15 Oct 2001 15:06:42 +0200 (CEST),
> Cristiano Paris <c.paris@libero.it> wrote:
> >I'm interested in developing a file system which could take features from
> >ramfs and cramfs so I have a couple of questions which possibly Linus
> >would answer to.
> >Second, quoting from the jffs2's TODO list :
> >
> >- fix zlib. It's ugly as hell and there are at least three copies in the
> >kernel tree
> 
> The -ac tree is moving to a single copy of zlib, in fs/inflate_fs.  It
> is currently used by cramfs and zisofs.  jffs2 in the -ac tree still
> uses its own copy of zlib and should be converted.

Any plans to fix this for the Linus tree?  Also, why place this in fs?
Shouldn't this be around for PPP along with other things that
can use it (like LKCD)?

--Matt
