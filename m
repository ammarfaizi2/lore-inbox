Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280627AbRKNPQU>; Wed, 14 Nov 2001 10:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280632AbRKNPQK>; Wed, 14 Nov 2001 10:16:10 -0500
Received: from zok.SGI.COM ([204.94.215.101]:63142 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S280627AbRKNPP7>;
	Wed, 14 Nov 2001 10:15:59 -0500
Subject: Re: File server FS?
From: Steve Lord <lord@sgi.com>
To: Robert Szentmihalyi <robert.szentmihalyi@entracom.de>
Cc: Sean Elble <S_Elble@yahoo.com>, Mike Fedyk <mfedyk@matchmail.com>,
        Brian <hiryuu@envisiongames.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200111141142227.SM00162@there>
In-Reply-To: <200111132203.fADM3jW03006@demai05.mw.mediaone.net>
	<20011113175348.B24864@mikef-linux.matchmail.com>
	<028201c16cb0$f489ccc0$0a00a8c0@intranet.mp3s.com> 
	<200111141142227.SM00162@there>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.11.08.57 (Preview Release)
Date: 14 Nov 2001 09:10:17 -0600
Message-Id: <1005750618.23586.14.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-11-14 at 04:41, Robert Szentmihalyi wrote:
> Am Mittwoch, 14. November 2001 03:05 schrieb Sean Elble:
> > I'd have to recommend XFS for you . . . it supports the kernel
> > mode NFS server very well, it supports LVM, an XFS file system
> > can be enlarged (not reduced), and XFS has great quota support,
> > just be sure you use a 3.0 or greater quota tools package. Why
> > use XFS over Ext3 you ask? XFS is faster, and scales better,
> > IMHO. Again just my opinion, but I hope that helps.
> >
> 
> ACK.
> We have built an 800 GB file server for a customer about three 
> month ago using XFS on a 3ware RAID.
> The server performs great, even under heay load.
> The only drawback is that group quotas were not yet supported then.
> I don't know if this has changed yet, but it should be fairly easy 
> to find out..... :-)
> 
> cheers,
>  Robert
> 

XFS on linux has had group quota support for quite a while - certainly
longer than 3 months. All the other features are available too.

Steve

-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com
