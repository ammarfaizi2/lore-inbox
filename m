Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267118AbSKXB1q>; Sat, 23 Nov 2002 20:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267119AbSKXB1q>; Sat, 23 Nov 2002 20:27:46 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:59407 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S267118AbSKXB1p>; Sat, 23 Nov 2002 20:27:45 -0500
Date: Sun, 24 Nov 2002 01:34:51 +0000
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: New module loader makes kernel debugging much harder
Message-ID: <20021124013451.GB58002@compsoc.man.ac.uk>
References: <20021124010617.GA58002@compsoc.man.ac.uk> <25797.1038100726@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25797.1038100726@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *18Flfg-000Fql-00*zHDPCChVdZI* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 24, 2002 at 12:18:46PM +1100, Keith Owens wrote:

> How do you know if the sections are "simply mapped"?  The module loader
> could assign different sections to different mappings, there is no
> guarantee that they are contiguous.  They were contiguous using the 2.4
> module loader but only because the syscall only allowed for a single
> area.  The new loader can assign sections anywhere it likes.

Mmmm, good point. So I will need full section info too. And some
userspace changes to cope with such ...

thanks
john
-- 
Khendon's Law: If the same point is made twice by the same person,
the thread is over.
