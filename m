Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276527AbRJCQyQ>; Wed, 3 Oct 2001 12:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276538AbRJCQyG>; Wed, 3 Oct 2001 12:54:06 -0400
Received: from port5.ds1-sby.adsl.cybercity.dk ([212.242.169.198]:5419 "EHLO
	trider-g7.int.fabbione.net") by vger.kernel.org with ESMTP
	id <S276527AbRJCQxu>; Wed, 3 Oct 2001 12:53:50 -0400
Message-ID: <3BBB42B7.860458EB@fabbione.net>
Date: Wed, 03 Oct 2001 18:54:15 +0200
From: Fabbione <fabbione@fabbione.net>
Reply-To: fabbione@fabbione.net
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "sebastien.cabaniols" <sebastien.cabaniols@laposte.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [POT] Which journalised filesystem uses Linus Torvalds ?
In-Reply-To: <GKMPCZ$IZh2dKhbICnp0WDXKHB6iO7OKoHwqOxmqj9XfriOC7PjHiIDA6bHi6xrImT@laposte.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastien,
		I had the possiblity to poke around with ext3 and reiserfs,
but endup converting all my machine to ext3 for various reasons.

First of all we ext3 you don't need to re-format your partitions, so no
mkreiserfs or mke3fs
but a simple tune2fs. No need to backup all your data, rebuild on top of
the new fs and
reinstall and....

When I was testing reiserfs (it was atleast a couple of months ago) I
got very bad performance
but I know that they have improved performance within the 2.4.10 release
of the kernel
that unfortunatly seems having many other problems.

Fabbione

"sebastien.cabaniols" wrote:
> 
> Hello lkml,
> 
> With the availability of XFS,JFS,ext3 and ReiserFS I am a
> little
> lost and I don't know which one I should use for entreprise
> class
> servers.

-- 
Debian GNU/Linux Unstable Kernel 2.4.9
fabbione on irc.atdot.it #coredump #kchat | fabbione@fabbione.net
