Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317230AbSGNWRu>; Sun, 14 Jul 2002 18:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317232AbSGNWRt>; Sun, 14 Jul 2002 18:17:49 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:15890 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S317230AbSGNWRs>; Sun, 14 Jul 2002 18:17:48 -0400
Date: Mon, 15 Jul 2002 00:20:28 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: Sean Neakums <sneakums@zork.net>, linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Message-ID: <20020714222028.GB14244@louise.pinerecords.com>
References: <20020714205451.GD9202@zork.net> <Pine.LNX.4.33.0207141707430.21492-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0207141707430.21492-100000@coffee.psychology.mcmaster.ca>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.19-pre10/sparc SMP
X-Uptime: 40 days, 11:59
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > it was due to trying to put many thousands of files into a single flat
> > directory.
> exactly.  ext2 (and many other FSs) are simply not designed for obscenely
> large directories.  it's unclear why Joerg brought up this rather obvious
> strawman.

... and blamed it on the overall kernel architecture.

Well, at least I learned something today: with the ext[23] largedir
problem out of the way, Linux can be as much as five times faster
than Solaris in certain, very common FS operations.
