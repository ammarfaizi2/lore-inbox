Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbVLORr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbVLORr2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 12:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbVLORr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 12:47:28 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:42970 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750841AbVLORr0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 12:47:26 -0500
Date: Thu, 15 Dec 2005 17:47:25 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-m68k@vger.kernel.org
Subject: Re: [PATCH 2/3] m68k: compile fix - ADBREQ_RAW missing declaration
Message-ID: <20051215174725.GZ27946@ftp.linux.org.uk>
References: <20051215085516.GU27946@ftp.linux.org.uk> <Pine.LNX.4.61.0512151258200.1605@scrub.home> <20051215171645.GY27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051215171645.GY27946@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 05:16:45PM +0000, Al Viro wrote:
> So who should I put as the author?  You or Geert (or whatever attributions
> might have been in said big patch)?  Incidentally,  ADBREQ_RAW had leaked
> into mainline (sans definition) in 2.3.45-pre2, which was Feb 13 2000, i.e.
> more than 1.5 year before your commit, so there's quite a chunk of history
> missing...
> 
> I'm serious, BTW - I certainly would have no problem preserving attribution,
> but it simply hadn't been there.  CVS logs are only as good as the data
> being put there by committers...

With some archaeology...  It looks like drivers/macintosh part is from
Geert (with chunks from benh? not sure) circa Dec 2000; adb.h is a missing
piece of earlier patch (one that had leaked in Feb 2000, $DEITY knowns how
much older it is)...
