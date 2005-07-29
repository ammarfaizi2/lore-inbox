Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262344AbVG2Emx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbVG2Emx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 00:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262325AbVG2Emx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 00:42:53 -0400
Received: from nproxy.gmail.com ([64.233.182.206]:50354 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262345AbVG2Emw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 00:42:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=trR/rES7MDlzpeU7IbjdKeF64pok45EJCwhUMPiJTTUUGY0BKkfbgaPeHgaWpF4w7qti1HtwMKJhduOccxyf3YvyHlxQuaKm3IZiitoapWNqV4y/8D77ReraLjIQkpmkaH4vuYgfDosnbfiwfelRjzGlkii7Gn3fgTylWJY5YrE=
Message-ID: <2cd57c900507282142137db5ee@mail.gmail.com>
Date: Fri, 29 Jul 2005 12:42:50 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@lovecn.org
To: linux-kernel@vger.kernel.org
Subject: Re: include-linux-blkdevh-extern-inline-static-inline.patch added to -mm tree
Cc: bunk@stusta.de, Andrew Morton <akpm@osdl.org>
In-Reply-To: <2cd57c9005072820073091864@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200507290229.j6T2T6MP003818@shell0.pdx.osdl.net>
	 <2cd57c9005072820073091864@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/05, Coywolf Qi Hunt <coywolf@gmail.com> wrote:
> On 7/29/05, akpm@osdl.org <akpm@osdl.org> wrote:
> >
> > The patch titled
> >
> >      include/linux/blkdev.h: "extern inline" -> "static inline"
> >
> > has been added to the -mm tree.  Its filename is
> >
> >      include-linux-blkdevh-extern-inline-static-inline.patch
> >
> 
> ...
> 
> >
> >
> > From: Adrian Bunk <bunk@stusta.de>
> >
> > "extern inline" doesn't make much sense.
> 
> "extern inline" does make sense, and it does make sense here. please
> backout this patch. Hint: the address of block_size() is referenced.
> 

Sorry, I mistook put_int(arg, block_size(bdev)); as address reference.

-- 
Coywolf Qi Hunt
http://ahbl.org/~coywolf/
