Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136688AbREJOms>; Thu, 10 May 2001 10:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136698AbREJOmh>; Thu, 10 May 2001 10:42:37 -0400
Received: from idiom.com ([216.240.32.1]:5900 "EHLO idiom.com")
	by vger.kernel.org with ESMTP id <S136688AbREJOmV>;
	Thu, 10 May 2001 10:42:21 -0400
Message-ID: <3AFAA8BC.EC219B5@namesys.com>
Date: Thu, 10 May 2001 07:42:04 -0700
From: Hans Reiser <reiser@namesys.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14cl i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: reiserfs, xfs, ext2, ext3
In-Reply-To: <01050910381407.26653@bugs> <20010510134453.A6816@emma1.emma.line.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:

>
> If you're deploying a cache partition such as /var/squid (possibly
> having log files in another /var/log partition on another disk drive),
> what's the point about not running (e.  g.) mke2fs and squid -z on boot,
> as well as mounting the system partitions (/usr) read-only (prevents
> fsck on next reboot)? mke2fs is faster than reiserfs recovery probably
> ;-)

For that particular application of squid, it happens we are much much faster
than ext2, if you apply all the right tunings and especially if you apply the
reiserfs_raw patch.

Hans

