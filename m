Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271869AbRIIEGG>; Sun, 9 Sep 2001 00:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271871AbRIIEF4>; Sun, 9 Sep 2001 00:05:56 -0400
Received: from femail32.sdc1.sfba.home.com ([24.254.60.22]:60668 "EHLO
	femail32.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S271869AbRIIEFg>; Sun, 9 Sep 2001 00:05:36 -0400
From: Josh McKinney <forming@home.com>
Date: Sat, 8 Sep 2001 23:05:39 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-pre5
Message-ID: <20010908230539.A4927@home.com>
Mail-Followup-To: josh, linux-kernel@vger.kernel.org
In-Reply-To: <E15fhnT-0003np-00@the-village.bc.nu> <3B9A95C7.DDF81890@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B9A95C7.DDF81890@oracle.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since I have gotten a decent amount of flame mail from my one-liner posted 
yesterday, I am just curious.  Has anyone really been able to successfully
compile their kernel with gcc-3*.  I did once or twice long before it was
released, but it dies on the same error everytime.  I posted it to the 
GCC mailing list because it was an internal compiler error, but it went
unanswered, along with other reports of the same bug.  Anyway, I just want
to see if someone really is able to use it as a reliable compiler.

Josh

On approximately Sun, Sep 09, 2001 at 12:03:51AM +0200, Alessandro Suardi wrote:
> Alan Cox wrote:
> > 
> > > ferred-stack-boundary=2 -march=i586 -DMODULE   -c -o rd.o rd.c
> > > > rd.c: In function `rd_ioctl':
> > > > rd.c:262: invalid type argument of `->'
> > > > rd.c: In function `rd_cleanup':
> > > > rd.c:375: too few arguments to function `blkdev_put'
> > 
> > 2.4.10pre5 doesnt compile for rd. It looks like the same error I got when
> > I applied Al's patch to -ac (and thus took it back out)
> 
> Just in case anybody wondered it doesn't compile with gcc-3.0.1 either.
> 
> --alessandro
> 
>  "this is no time to get cute, it's a mad dog's promenade
>   so walk tall, or baby don't walk at all"
>                 (Bruce Springsteen, 'New York City Serenade')
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Linux, the choice          | Magic is always the best solution --
of a GNU generation   -o)  | especially reliable magic. 
Kernel 2.4.9-ac1       /\  | 
on a i586             _\_v | 
                           | 
