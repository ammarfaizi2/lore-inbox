Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266649AbSL3Dz6>; Sun, 29 Dec 2002 22:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266650AbSL3Dz5>; Sun, 29 Dec 2002 22:55:57 -0500
Received: from [65.198.37.67] ([65.198.37.67]:52451 "EHLO funky.gghcwest.com")
	by vger.kernel.org with ESMTP id <S266649AbSL3Dz5>;
	Sun, 29 Dec 2002 22:55:57 -0500
Date: Sun, 29 Dec 2002 20:04:02 -0800
From: Jeffrey Baker <jwbaker@acm.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 oops mounting iso9660 fs as hfs
Message-ID: <20021230040402.GA680@heat>
References: <20021230005457.GA15680@noodles> <E18SqVf-0005xV-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E18SqVf-0005xV-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2002 at 02:22:35PM +1100, Herbert Xu wrote:
> Jeffrey Baker <jwbaker@acm.org> wrote:
> > Using kernel 2.4.20 on ix86 and an HP IEEE1394 DVD+RW drive, I
> > encountered this BUG/oops when attempting to mount a CD-ROM.  I at
> > first could not mount the disc, so I attempted to mount it as HFS:
> 
> HFS wants 512 blocks while sr sets hardsect size to 2048.  You can
> work around it by reading it via loopback (losetup or mount -o loop).

Do you mean make an image of the CD with dd and mount it
with loopback?  That sounds like it would work fine.

