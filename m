Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316613AbSEPJT0>; Thu, 16 May 2002 05:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316614AbSEPJTZ>; Thu, 16 May 2002 05:19:25 -0400
Received: from balu.sch.bme.hu ([152.66.208.40]:27124 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S316613AbSEPJTZ>;
	Thu, 16 May 2002 05:19:25 -0400
Date: Thu, 16 May 2002 11:19:22 +0200 (MEST)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: Tomas Szepe <szepe@pinerecords.com>
cc: =?iso-8859-2?Q?J=F6rg?= Prante <joergprante@gmx.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHSET] 2.4.19-pre8-jp12
In-Reply-To: <20020516090505.GB954@louise.pinerecords.com>
Message-ID: <Pine.GSO.4.30.0205161118200.17481-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > But the worst problem for is supermount:
> > # mount -t supermount -o dev=/dev/cdrom none /mnt/cdrom
> > # ls -l /mnt/cdrom
> > ls: .: Stale NFS handle                (~or something similar)
> > [...]                                  (and it lists the file)
>
> Hmmm.. I've been seeing this problem in the latest -ac kernels too.
>
> Basically, a while after mounting the CD a ls on any subdir of the
> mount will complain about a 'stale NFS handle' and the device has
> to be remounted.

I thougth it wasn't Jorg's fault :). Unfortunately I immediately get this
message :(.

-- 
Balazs Pozsar

