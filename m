Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTJNBCG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 21:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbTJNBCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 21:02:06 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:28579 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S262123AbTJNBCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 21:02:04 -0400
Date: Mon, 13 Oct 2003 18:00:51 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: nfs fstat st_blocks overreporting
Message-ID: <20031013180051.A8501@google.com>
References: <20031013075316.A16032@google.com> <16266.50390.93346.47602@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16266.50390.93346.47602@charged.uio.no>; from trond.myklebust@fys.uio.no on Mon, Oct 13, 2003 at 11:29:26AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 13, 2003 at 11:29:26AM -0400, Trond Myklebust wrote:
> >>>>> " " == Frank Cusack <fcusack@fcusack.com> writes:
> 
>      > While you know I disagree that s_blocksize should be wtmult
>      > (ie, it is wtmult?wtmult:512 and I think it should be
>      > MAX(rsize,wsize)), in any event the blocks used reporting is
>      > incorrect in that it assumes a 512 byte blocksize.
> 
> Frank,
> 
>      man 2 stat
> 
>   i_blocks a.k.a. stat->st_blocks is _defined_ to be in 512byte
> units. It bears no relation to the st_blksize. If you don't like that,
> spec then by all means appeal to the POSIX committee that wrote
> it. (You probably wouldn't be the first to do so)
> 
>   Pending the outcome of such an appeal, though, the patch must be
> rejected...

I'm an idiot.

/fc
