Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284017AbRLEKmN>; Wed, 5 Dec 2001 05:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284022AbRLEKmD>; Wed, 5 Dec 2001 05:42:03 -0500
Received: from pD903C85F.dip.t-dialin.net ([217.3.200.95]:16056 "EHLO
	no-maam.dyndns.org") by vger.kernel.org with ESMTP
	id <S284017AbRLEKll>; Wed, 5 Dec 2001 05:41:41 -0500
Date: Wed, 5 Dec 2001 11:40:28 +0100
To: Rasmus =?iso-8859-1?B?Qvhn?= Hansen <moffe@amagerkollegiet.dk>
Cc: Erik Tews <erik.tews@gmx.net>, Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        linux-kernel@vger.kernel.org
Subject: Re: tuning ext2 or ReiserFS to avoid fragmentation with large files?
Message-ID: <20011205114028.A1268@no-maam.dyndns.org>
In-Reply-To: <20011204142047.N11967@no-maam.dyndns.org> <Pine.LNX.4.33.0112050315450.2930-100000@grignard.amagerkollegiet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.33.0112050315450.2930-100000@grignard.amagerkollegiet.dk>
User-Agent: Mutt/1.3.23i
From: erik.tews@gmx.net (Erik Tews)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2001 at 03:17:17AM +0100, Rasmus Bøg Hansen wrote:
> On Tue, 4 Dec 2001, Erik Tews wrote:
> 
> > If I remember right xfs has got a online-defragmentation utility. So
> > have a look at xfs.
> > 
> > I think xfs works different from reiserfs and ext2 when writing files to
> > disk which helps avoiding fragmentation. This feature is called
> > allocation groups.
> 
> I *might* be wrong, but isn't the allocation-group thing exactly what 
> ext2/ext3 does?
> 
> I don't know about reiserfs and fragmentation, however.

I am sure that xfs is doing that and reiserfs is not doing that.

But I am not sure about ext2 and ext3.

Reiserfs4 is going to be different, and it will have a
online-defragmentation utility.
