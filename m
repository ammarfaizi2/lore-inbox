Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271712AbRIHWCf>; Sat, 8 Sep 2001 18:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271708AbRIHWCQ>; Sat, 8 Sep 2001 18:02:16 -0400
Received: from inet-mail3.oracle.com ([148.87.2.203]:9676 "EHLO
	inet-mail3.oraclecorp.com") by vger.kernel.org with ESMTP
	id <S271678AbRIHWCI>; Sat, 8 Sep 2001 18:02:08 -0400
Message-ID: <3B9A95C7.DDF81890@oracle.com>
Date: Sun, 09 Sep 2001 00:03:51 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kingsley Foreman <kingsley@wintronics.com.au>
Subject: Re: 2.4.10-pre5
In-Reply-To: <E15fhnT-0003np-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > ferred-stack-boundary=2 -march=i586 -DMODULE   -c -o rd.o rd.c
> > > rd.c: In function `rd_ioctl':
> > > rd.c:262: invalid type argument of `->'
> > > rd.c: In function `rd_cleanup':
> > > rd.c:375: too few arguments to function `blkdev_put'
> 
> 2.4.10pre5 doesnt compile for rd. It looks like the same error I got when
> I applied Al's patch to -ac (and thus took it back out)

Just in case anybody wondered it doesn't compile with gcc-3.0.1 either.

--alessandro

 "this is no time to get cute, it's a mad dog's promenade
  so walk tall, or baby don't walk at all"
                (Bruce Springsteen, 'New York City Serenade')
