Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316610AbSEPJFN>; Thu, 16 May 2002 05:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316611AbSEPJFM>; Thu, 16 May 2002 05:05:12 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:11524 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S316610AbSEPJFL>; Thu, 16 May 2002 05:05:11 -0400
Date: Thu, 16 May 2002 11:05:05 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Pozsar Balazs <pozsy@sch.bme.hu>
Cc: =?iso-8859-2?Q?J=F6rg?= Prante <joergprante@gmx.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHSET] 2.4.19-pre8-jp12
Message-ID: <20020516090505.GB954@louise.pinerecords.com>
In-Reply-To: <200205150007.AWD57178@netmail.netcologne.de> <Pine.GSO.4.30.0205160941040.956-100000@balu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: Linux/sparc 2.2.21-rc4-ext3-0.0.7a SMP (up 2:33)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But the worst problem for is supermount:
> # mount -t supermount -o dev=/dev/cdrom none /mnt/cdrom
> # ls -l /mnt/cdrom
> ls: .: Stale NFS handle                (~or something similar)
> [...]                                  (and it lists the file)

Hmmm.. I've been seeing this problem in the latest -ac kernels too.

Basically, a while after mounting the CD a ls on any subdir of the
mount will complain about a 'stale NFS handle' and the device has
to be remounted.

T.
