Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292326AbSBBRPy>; Sat, 2 Feb 2002 12:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292327AbSBBRPo>; Sat, 2 Feb 2002 12:15:44 -0500
Received: from ns.caldera.de ([212.34.180.1]:47021 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S292326AbSBBRPa>;
	Sat, 2 Feb 2002 12:15:30 -0500
Date: Sat, 2 Feb 2002 18:14:15 +0100
Message-Id: <200202021714.g12HEF524703@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: akpm@zip.com.au (Andrew Morton)
Cc: linux-kernel@vger.kernel.org, Ricardo Galli <gallir@uib.es>
Subject: Re: O_DIRECT fails in some kernel and FS
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <3C5AFE2D.95A3C02E@zip.com.au>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.13 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3C5AFE2D.95A3C02E@zip.com.au> you wrote:
>> Oliver Diedrich also told he could make work O_DIRECT with ext3 and 2.4.17.
>> 
>> Is this normal? Does it really work on 2.4.14? Or it doesn't but the kernel
>> doesn't avoid caching?
>> 
>
> ext2 is the only filesystem which has O_DIRECT support.

You forgot JFS and XFS.  Also there is a patche for NFS, but this one
requires a prototype change for ->directIO.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
