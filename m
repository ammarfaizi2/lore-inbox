Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279261AbRKXRuB>; Sat, 24 Nov 2001 12:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279233AbRKXRtv>; Sat, 24 Nov 2001 12:49:51 -0500
Received: from xdsl-213-168-117-4.netcologne.de ([213.168.117.4]:16522 "EHLO
	ecce.homeip.net") by vger.kernel.org with ESMTP id <S279228AbRKXRtk>;
	Sat, 24 Nov 2001 12:49:40 -0500
Date: Sat, 24 Nov 2001 17:49:31 +0000 (UTC)
From: Thorsten Glaser <mirabilos@users.sourceforge.net>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Andreas Dilger <adilger@turbolabs.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Moving ext3 journal file
In-Reply-To: <3BFF2AAE.7000000@zytor.com>
Message-ID: <Pine.BSO.4.42.0111241748250.6453-100000@ecce.homeip.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dixitur de H. Peter Anvin respondebo ad:
> Andreas Dilger wrote:
(...)
> > Because .journal is created as immutable, even if it was backed up and
> > tried to be restored, it would be impossible to write to.  For the
> > "accursed" ext2 dump, it recognizes the "nodump" flag, but also knows
> > enough not to back up the journal file.  Sadly, neither cpio or tar
> > know about ext2 attributes.
> Nor scp, nor rsync, nor find, nor...

Neither they do about UCB FFS attributes... they even have separate
user/system immutable flags :)

What about pax(1)? I guess it doesn't either, because cpio is just pax.

-mirabilos
-- 
| This message body is covered by Germanic and International | OpenBSD30
| Copyright law. Modification of any kind and redistribution | centericq
| via AOL or the Microsoft network are strictly prohibited!! | UIN seems
| Scientific-style quotation permitted if due credits given. | 132315236

