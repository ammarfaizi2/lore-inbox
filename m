Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319260AbSHNR7V>; Wed, 14 Aug 2002 13:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319261AbSHNR7V>; Wed, 14 Aug 2002 13:59:21 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:47377 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S319260AbSHNR7V>; Wed, 14 Aug 2002 13:59:21 -0400
Date: Wed, 14 Aug 2002 19:03:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Javier Marcet <jmarcet@pobox.com>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre2-ac1
Message-ID: <20020814190313.A22068@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Javier Marcet <jmarcet@pobox.com>, Alan Cox <alan@redhat.com>,
	linux-kernel@vger.kernel.org
References: <200208141634.g7EGYGO29387@devserv.devel.redhat.com> <20020814175455.GA5254@jerry.boludo.cjb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020814175455.GA5254@jerry.boludo.cjb.net>; from jmarcet@pobox.com on Wed, Aug 14, 2002 at 07:54:55PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2002 at 07:54:55PM +0200, Javier Marcet wrote:
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.20-pre2-ac1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon-xp    -nostdinc -I /usr/lib/gcc-lib/i686-pc-linux-gnu/3.2/include -DKBUILD_BASENAME=check  -DEXPORT_SYMTAB -c check.c
> check.c: In function `devfs_register_disc':
> check.c:328: structure has no member named `number'
> check.c:329: structure has no member named `number'
> check.c: In function `devfs_register_partitions':
> check.c:361: structure has no member named `number'

This is also present in plain 2.4.20-pre2 and I sent the fix to Marcelo and
this list a few hours before -pre2 was released.

