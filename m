Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263098AbREaN6b>; Thu, 31 May 2001 09:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263099AbREaN6V>; Thu, 31 May 2001 09:58:21 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:64008
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S263098AbREaN6H>; Thu, 31 May 2001 09:58:07 -0400
Date: Thu, 31 May 2001 09:57:38 -0400
From: Chris Mason <mason@suse.com>
To: Lukasz Trabinski <lukasz@wsisiz.edu.pl>, linux-kernel@vger.kernel.org
Subject: Re: reiserfs_read_inode2
Message-ID: <877710000.991317458@tiny>
In-Reply-To: <Pine.LNX.4.33.0105311425110.21274-100000@oceanic.wsisiz.edu.pl>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, May 31, 2001 02:27:26 PM +0200 Lukasz Trabinski
<lukasz@wsisiz.edu.pl> wrote:

> Hello
> 
> What it's means?
> 
> portraits:~# dmesg
> vs-13042: reiserfs_read_inode2: [2299 593873 0x0 SD] not found
> vs-13048: reiserfs_iget: bad_inode. Stat data of (2299 593873) not found
> vs-13042: reiserfs_read_inode2: [2299 593807 0x0 SD] not found
> vs-13048: reiserfs_iget: bad_inode. Stat data of (2299 593807) not found
> 
> 2.4.5 with lock_kernel/unlock patch,reiserfsprogs 3.x.0h, RH 7.1

In this case, it probably means you are serving NFS from that disk, which
needs extra patches.  Are you?

-chris

