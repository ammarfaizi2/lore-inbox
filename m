Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291592AbSBAHlB>; Fri, 1 Feb 2002 02:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291591AbSBAHkv>; Fri, 1 Feb 2002 02:40:51 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:14475 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S291590AbSBAHkh>; Fri, 1 Feb 2002 02:40:37 -0500
Message-Id: <200201312226.g0VMQIKV001568@tigger.cs.uni-dortmund.de>
To: Andrea Arcangeli <andrea@suse.de>
cc: Momchil Velikov <velco@fadata.bg>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radix tree page cache 
In-Reply-To: Message from Andrea Arcangeli <andrea@suse.de> 
   of "Thu, 31 Jan 2002 03:25:40 +0100." <20020131032540.W1309@athlon.random> 
Date: Thu, 31 Jan 2002 23:26:18 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> said:
> On Wed, Jan 30, 2002 at 10:25:44PM +0200, Momchil Velikov wrote:
> > Linus,
> > 
> > Please, consider for inclusion in 2.5.3 series the following radix
> > tree page cache patch.
> 
> Please benchmark on files 10giga large, only do cached I/O (reads are
> fine) between 9G and 10G offset for example.

All published data I've seen on file size distribution on Unix show that
the overwhelming mayority of files is a few KiB long, so this is a corner
case. Why benchmark it expressly?
-- 
Horst von Brand			     http://counter.li.org # 22616
