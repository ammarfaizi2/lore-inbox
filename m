Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313560AbSDUQfp>; Sun, 21 Apr 2002 12:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313562AbSDUQfo>; Sun, 21 Apr 2002 12:35:44 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39695 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313560AbSDUQfm>; Sun, 21 Apr 2002 12:35:42 -0400
Date: Sun, 21 Apr 2002 17:35:35 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jan Niehusmann <jan@gondor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3: i_blocks is xx, should be yy
Message-ID: <20020421173535.C20834@flint.arm.linux.org.uk>
In-Reply-To: <20020421162915.GA28414@gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2002 at 06:29:15PM +0200, Jan Niehusmann wrote:
> On an (otherwise clean, and cleanly unmounted) ext3 partition, I got
> some ext2fs errors like the following:
> 
> Inode 295208, i_blocks is 112, should be 8.  Fix<y>?

Did the filesystem run out of free blocks at any point?

If so, the following could explain it:

http://marc.theaimsgroup.com/?l=linux-kernel&m=101778284030725&w=2

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

