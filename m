Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262681AbVHDUWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262681AbVHDUWr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 16:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbVHDUWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 16:22:33 -0400
Received: from mailfe15.tele2.se ([212.247.155.193]:7904 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262667AbVHDUUb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 16:20:31 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Date: Thu, 4 Aug 2005 22:20:25 +0200
From: Alexander Nyberg <alexn@telia.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: x86_64 access of some bad address
Message-ID: <20050804202025.GA4101@localhost.localdomain>
References: <1119539630.1170.6.camel@localhost.localdomain> <20050804131512.7d464fad.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050804131512.7d464fad.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2005 at 01:15:12PM -0700 Andrew Morton wrote:

> Alexander Nyberg <alexn@telia.com> wrote:
> >
> > As I only have one x86_64 which is my main workstation it's far too
> > tedious to do binary searching (this doesn't happen on x86).
> > 
> > Happens with both latest -git and 2.6.12-mm1
> > The tools to reproduce this is at: http://serkiaden.mine.nu/kp2.tar
> > 
> > Just do:
> > gdb lyze
> > run
> > 
> > and it crashes here giving:
> > 
> > ----------- [cut here ] --------- [please bite here ] ---------
> > Kernel BUG at "mm/memory.c":911
> 
> So I think Hugh's patch this morning should fix this up.  Please retest
> -rc6 when it's out?

Maybe I forgot to tell but I've already tested and it works fine.
