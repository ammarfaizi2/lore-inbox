Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290806AbSBNHft>; Thu, 14 Feb 2002 02:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290852AbSBNHfj>; Thu, 14 Feb 2002 02:35:39 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:33042 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S290806AbSBNHf3>;
	Thu, 14 Feb 2002 02:35:29 -0500
Date: Thu, 14 Feb 2002 08:35:00 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Frank Jacobberger <f1j@xmission.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.5-pre1 and rd.c
Message-ID: <20020214083500.H705@suse.de>
In-Reply-To: <3C6B1883.8080105@xmission.com> <3C6B203A.61167C55@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C6B203A.61167C55@mandrakesoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13 2002, Jeff Garzik wrote:
> Frank Jacobberger wrote:
> > 
> > Trying a make bzImage netted this nice little problem:
> > ------------------------------------------------------------------------------------------------------------------------------
> > gcc -D__KERNEL__ -I/usr/src/linux-2.5.4/include -Wall -Wstrict-prototypes
> > -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
> > -pipe
> > -mpreferred-stack-boundary=2 -march=i686   -DKBUILD_BASENAME=rd  -c -o
> > rd.o rd.c
> > rd.c: In function `rd_make_request':
> > rd.c:271: too many arguments to function
> 
> I would have sworn I merged that with axboe.

You did, apparently Linus never did the pull on that one. I'll make sure
it gets pushed again :)

-- 
Jens Axboe

