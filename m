Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280665AbRKNQKV>; Wed, 14 Nov 2001 11:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280674AbRKNQKM>; Wed, 14 Nov 2001 11:10:12 -0500
Received: from eispost12.serverdienst.de ([212.168.16.111]:58636 "EHLO imail")
	by vger.kernel.org with ESMTP id <S280665AbRKNQJy>;
	Wed, 14 Nov 2001 11:09:54 -0500
Content-Type: text/plain; charset=US-ASCII
From: Robert Szentmihalyi <robert.szentmihalyi@entracom.de>
To: Steve Lord <lord@sgi.com>
Subject: Re: File server FS?
Date: Wed, 14 Nov 2001 17:09:39 +0100
X-Mailer: KMail [version 1.3]
Cc: Sean Elble <S_Elble@yahoo.com>, Mike Fedyk <mfedyk@matchmail.com>,
        Brian <hiryuu@envisiongames.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200111132203.fADM3jW03006@demai05.mw.mediaone.net> <200111141142227.SM00162@there> <1005750618.23586.14.camel@jen.americas.sgi.com>
In-Reply-To: <1005750618.23586.14.camel@jen.americas.sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200111141711398.SM00162@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 2001-11-14 at 04:41, Robert Szentmihalyi wrote:
> > Am Mittwoch, 14. November 2001 03:05 schrieb Sean Elble:
> > > I'd have to recommend XFS for you . . . it supports the
> > > kernel mode NFS server very well, it supports LVM, an XFS
> > > file system can be enlarged (not reduced), and XFS has great
> > > quota support, just be sure you use a 3.0 or greater quota
> > > tools package. Why use XFS over Ext3 you ask? XFS is faster,
> > > and scales better, IMHO. Again just my opinion, but I hope
> > > that helps.
> >
> > ACK.
> > We have built an 800 GB file server for a customer about three
> > month ago using XFS on a 3ware RAID.
> > The server performs great, even under heay load.
> > The only drawback is that group quotas were not yet supported
> > then. I don't know if this has changed yet, but it should be
> > fairly easy to find out..... :-)
> >
> > cheers,
> >  Robert
>
> XFS on linux has had group quota support for quite a while -
> certainly longer than 3 months. All the other features are
> available too.

Nice to know :-)
I have not tried it since the FAQ at 
http://oss.sgi.com/projects/xfs/faq.html#quotaswork
said it didn't. (It still does, by the way. Perhaps you could 
update the FAQ :-))

>
> Steve

Robert

-- 
Where do you want to be tomorrow?

Entracom. Building Linux systems.
http://www.entracom.de
