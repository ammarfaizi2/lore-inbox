Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287710AbSASWml>; Sat, 19 Jan 2002 17:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287705AbSASWmb>; Sat, 19 Jan 2002 17:42:31 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:19398 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S287699AbSASWma>; Sat, 19 Jan 2002 17:42:30 -0500
Date: Sun, 20 Jan 2002 00:42:11 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Jakob =?iso-8859-1?Q?=D8stergaard?= <jakob@unthought.net>,
        Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  January 18, 2002
Message-ID: <20020119224210.GI51774@niksula.cs.hut.fi>
In-Reply-To: <3C477B7F.22875.11D4078A@localhost> <Pine.GSO.4.21.0201180546310.296-100000@weyl.math.psu.edu> <3C488E84.A1453ED2@zip.com.au> <20020119184259.GE135220@niksula.cs.hut.fi> <20020119232455.D12692@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020119232455.D12692@unthought.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2002 at 11:24:55PM +0100, you [Jakob Østergaard] claimed:
>
> That would be *very* nice indeed.  Even if it was only for things like NFS
> and SMBFS.
> 
> And even if it is unsafe - it's a lot better to be able to say "screw
> those pending writes", than to have to say "screw the pending writes by
> rebooting the system".

Last time this was discussed on the list, Tigran Aivazian mentioned this
patch:

http://www.moses.uklinux.net/patches/forced-umount-2.4.9.patch

I haven't tested it, but it seems better than "fuser -k -m /fs" (and the
problem I've faced is that if there's something wrong (like HW level IO
problems) kill -KILL won't work).


-- v --

v@iki.fi
