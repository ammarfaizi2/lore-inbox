Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278522AbRJPEfh>; Tue, 16 Oct 2001 00:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278524AbRJPEf1>; Tue, 16 Oct 2001 00:35:27 -0400
Received: from zok.sgi.com ([204.94.215.101]:25251 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S278522AbRJPEfT>;
	Tue, 16 Oct 2001 00:35:19 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Cristiano Paris <c.paris@libero.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: libz, libbz2, ramfs and cramfs 
In-Reply-To: Your message of "Mon, 15 Oct 2001 15:06:42 +0200."
             <Pine.LNX.4.33.0110151436040.755-100000@lisa.rhpk.springfield.inwind.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 16 Oct 2001 14:35:43 +1000
Message-ID: <19978.1003206943@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2001 15:06:42 +0200 (CEST), 
Cristiano Paris <c.paris@libero.it> wrote:
>I'm interested in developing a file system which could take features from
>ramfs and cramfs so I have a couple of questions which possibly Linus
>would answer to.
>Second, quoting from the jffs2's TODO list :
>
>- fix zlib. It's ugly as hell and there are at least three copies in the
>kernel tree

The -ac tree is moving to a single copy of zlib, in fs/inflate_fs.  It
is currently used by cramfs and zisofs.  jffs2 in the -ac tree still
uses its own copy of zlib and should be converted.

