Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265806AbTATNae>; Mon, 20 Jan 2003 08:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265815AbTATNae>; Mon, 20 Jan 2003 08:30:34 -0500
Received: from uni02du.unity.ncsu.edu ([152.1.13.102]:24192 "EHLO
	uni02du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id <S265806AbTATNae>; Mon, 20 Jan 2003 08:30:34 -0500
From: jlnance@unity.ncsu.edu
Date: Mon, 20 Jan 2003 08:39:38 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [ANN] ntfsprogs (formerly Linux-NTFS) 1.7.0beta released
Message-ID: <20030120133938.GA2842@ncsu.edu>
References: <20030119091043.GA8856@ludicrus.ath.cx> <Pine.LNX.4.33.0301191600180.16178-100000@urtica.linuxnews.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0301191600180.16178-100000@urtica.linuxnews.pl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 19, 2003 at 04:05:50PM +0100, Pawel Kot wrote:

> There exists a new ntfs driver called NTFS-TNG, which is present already
> in 2.5.x kernel series and it has its backport to the 2.4.x kernel series
> (you'll find it at http://linux-ntfs.sf.net/).
> 
> This driver has no write support yet, but it allows you to overwrite the
> files, without changing their attributes and size (ie. mmap() the file,
> change the contents, write() the file). And the overwrite is considered
> safe.

Is this stable enough to allow you to put an ext2 image on an NTFS
partition and then mount that image as a r/w loopback mount from
Linux?

Thanks,

Jim
