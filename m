Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281791AbRKQSQK>; Sat, 17 Nov 2001 13:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281792AbRKQSQB>; Sat, 17 Nov 2001 13:16:01 -0500
Received: from pc-62-30-255-29-az.blueyonder.co.uk ([62.30.255.29]:46325 "EHLO
	kushida.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S281791AbRKQSP4>; Sat, 17 Nov 2001 13:15:56 -0500
Date: Sat, 17 Nov 2001 18:12:53 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Brian <hiryuu@envisiongames.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: File server FS?
Message-ID: <20011117181253.B5003@kushida.jlokier.co.uk>
In-Reply-To: <200111132203.fADM3jW03006@demai05.mw.mediaone.net> <20011113175348.B24864@mikef-linux.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011113175348.B24864@mikef-linux.matchmail.com>; from mfedyk@matchmail.com on Tue, Nov 13, 2001 at 05:53:48PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> >  * Resizing - See last point
> 
> There are two utilities to resize ext2, which ext3 is except for an
> additional file (journal) after umount.

Two questions:

  1. Does the size of the "appropriately sized journal (given the size
     of the filesystem)" vary with filesystem size?

  2. If so, does resize2fs change the journal size properly?

When I have resized ext3 filesystems, I have removed then recreated the
journal manually because it wasn't clear from the documentation whether
resize2fs does the appropriate thing.

Thanks,
-- Jamie
