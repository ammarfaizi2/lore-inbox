Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313128AbSEPPNS>; Thu, 16 May 2002 11:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313132AbSEPPNR>; Thu, 16 May 2002 11:13:17 -0400
Received: from [64.76.155.18] ([64.76.155.18]:18876 "EHLO alumno.inacap.cl")
	by vger.kernel.org with ESMTP id <S313128AbSEPPNR>;
	Thu, 16 May 2002 11:13:17 -0400
Date: Thu, 16 May 2002 11:08:14 -0400 (CLT)
From: Robinson Maureira Castillo <rmaureira@alumno.inacap.cl>
To: Tomas Szepe <szepe@pinerecords.com>
cc: Pozsar Balazs <pozsy@sch.bme.hu>,
        =?iso-8859-2?Q?J=F6rg?= Prante <joergprante@gmx.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHSET] 2.4.19-pre8-jp12
In-Reply-To: <20020516090505.GB954@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.44.0205161105520.5254-100000@alumno.inacap.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 May 2002, Tomas Szepe wrote:

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
> 
> T.
> 

I'm getting the same with ftpfs, both in jp11 and jp12. Remounting doesn't 
change a thing, it just shows me the root tree, I can cd into directories 
if I know the name, but all I got is those nice 'stale NFS handle' as a 
response from ls

Regards

Rob.

