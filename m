Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261373AbTC0VFA>; Thu, 27 Mar 2003 16:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261374AbTC0VFA>; Thu, 27 Mar 2003 16:05:00 -0500
Received: from public1-brig1-3-cust85.brig.broadband.ntl.com ([80.0.159.85]:40457
	"EHLO ppg_penguin.kenmoffat.uklinux.net") by vger.kernel.org
	with ESMTP id <S261373AbTC0VE7>; Thu, 27 Mar 2003 16:04:59 -0500
Date: Thu, 27 Mar 2003 21:16:01 +0000 (GMT)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Christian Laursen <xi@borderworlds.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: / listed twice in /proc/mounts
In-Reply-To: <m3d6kcbwwk.fsf@borg.borderworlds.dk>
Message-ID: <Pine.LNX.4.21.0303272110420.16348-100000@ppg_penguin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Mar 2003, Christian Laursen wrote:

> The other day, I upgraded the components of a software package
> that I maintain, including updating the kernel from 2.4.18 to
> 2.4.20.
> 
> I noticed something strange: / is now listed twice in /proc/mounts
> like this
> 
> rootfs / rootfs rw 0 0
> /dev/root / ext2 rw 0 0
> 
> It confused one of my scripts, so I had to implement a quick workaround.
> 
> Is this a feature or a bug?
> 

 Is your /etc/mtab a symlink to /proc/mounts ?  That is generally
thought not to be a good idea.

Ken
-- 
 Out of the darkness a voice spake unto me, saying "smile, things could be
worse". So I smiled, and lo, things became worse.



