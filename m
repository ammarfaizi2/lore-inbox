Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030230AbVHZTmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230AbVHZTmG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 15:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbVHZTmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 15:42:05 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:40576 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1030230AbVHZTmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 15:42:04 -0400
Date: Tue, 23 Aug 2005 23:31:14 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Pavel Machek <pavel@ucw.cz>, Christoph Hellwig <hch@infradead.org>,
       "Machida, Hiroyuki" <machida@sm.sony.co.jp>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Posix file attribute support on VFAT (take #2)
Message-ID: <20050823213114.GB846@openzaurus.ucw.cz>
References: <43023957.1020909@sm.sony.co.jp> <20050816212531.GA2479@infradead.org> <20050822114629.GA29046@elf.ucw.cz> <20050823140414.GA28578@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050823140414.GA28578@csclub.uwaterloo.ca>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Unfortunately, it makes sense. If you have compact flash card, you
> > really want to have VFAT there, so that it is a) compatible with
> > windows and b) so that you don't kill the hardware.
> 
> VFAT is plenty good at killing hardware.  It's a terrible filesystem for
> flash cards (if they don't do their own wear leveling properly).  Most

Well, they actually do test those cards with VFAT. Rumors are,
they have some VFAT specific hacks in flash card firmware.

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

