Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311469AbSCNC1N>; Wed, 13 Mar 2002 21:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311479AbSCNC1E>; Wed, 13 Mar 2002 21:27:04 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:50437 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S311469AbSCNC0w>; Wed, 13 Mar 2002 21:26:52 -0500
Message-ID: <3C900A11.55BA4B32@zip.com.au>
Date: Wed, 13 Mar 2002 18:25:21 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roberto Nibali <ratz@drugphish.ch>
CC: linux-kernel@vger.kernel.org
Subject: Re: Question about the ide related ioctl's BLK* in 2.5.7-pre1 kernel
In-Reply-To: <3C9007F5.1000003@drugphish.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roberto Nibali wrote:
> 
> Hi,
> 
> What for are BLKRAGET, BLKFRAGET and BLKSECTGET still needed?

They got collaterally damaged in the IDE "cleanup".  The patch at
http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.6/dallocbase-10-readahead.patch
resurrects them.

-
