Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268861AbRHTTJY>; Mon, 20 Aug 2001 15:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268896AbRHTTJP>; Mon, 20 Aug 2001 15:09:15 -0400
Received: from chunnel.redhat.com ([199.183.24.220]:28151 "EHLO
	dukat.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S268861AbRHTTJJ>; Mon, 20 Aug 2001 15:09:09 -0400
Date: Mon, 20 Aug 2001 19:10:46 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Riley Williams <rhw@MemAlpha.CX>
Cc: Dewet Diener <dewet@dewet.org>, Stephen C Tweedie <sct@redhat.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 partition unmountable
Message-ID: <20010820191046.D4389@redhat.com>
In-Reply-To: <20010818235211.A24646@darkwing.flatlit.net> <Pine.LNX.4.33.0108182257490.9206-100000@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0108182257490.9206-100000@infradead.org>; from rhw@MemAlpha.CX on Sat, Aug 18, 2001 at 11:04:41PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Aug 18, 2001 at 11:04:41PM +0100, Riley Williams wrote:

>  > # tune2fs -l /dev/hdd1
>  > tune2fs 1.22, 22-Jun-2001 for EXT2 FS 0.5b, 95/08/09
>  > tune2fs: Filesystem has unsupported feature(s) while trying to open /dev/hdd1
>  > Couldn't find valid filesystem superblock.
> 
> You have an old version of tune2fs, and need to get the one that knows
> about ext3 or alternatively apply the patch that was distributed some
> time ago and recompile - I'm not sure which.

No, 1.22 tune2fs knows about the journaling flags.

> Stephen: What's the current status regarding tune2fs and ext3, I'm a
> tad out of date in this respect?

As of 1.22, ext3 is fully supported by tune2fs.

>  > I'll probably have to take the drive back, and see if it now mounts
>  > in the original system :-/
> 
> That might help...

Indeed, I'd like to see what that gives you.

One quick question: are either of the machines big-endian (HPPA, PPC
etc)?

Cheers, 
 Stephen
