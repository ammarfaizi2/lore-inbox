Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131311AbRCUK6M>; Wed, 21 Mar 2001 05:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131315AbRCUK6C>; Wed, 21 Mar 2001 05:58:02 -0500
Received: from x86unx3.comp.nus.edu.sg ([137.132.90.2]:64746 "EHLO
	x86unx3.comp.nus.edu.sg") by vger.kernel.org with ESMTP
	id <S131311AbRCUK5z>; Wed, 21 Mar 2001 05:57:55 -0500
Date: Wed, 21 Mar 2001 18:56:45 +0800
From: Zou Min <zoum@comp.nus.edu.sg>
To: Andreas Dilger <adilger@turbolinux.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Josh Grebe <squash@primary.net>,
        Jan Harkes <jaharkes@cs.cmu.edu>, linux-kernel@vger.kernel.org
Subject: Re: Question about memory usage in 2.4 vs 2.2
Message-ID: <20010321185645.B5559@comp.nus.edu.sg>
Mail-Followup-To: Zou Min <zoum@comp.nus.edu.sg>,
	Andreas Dilger <adilger@turbolinux.com>,
	Rik van Riel <riel@conectiva.com.br>,
	Josh Grebe <squash@primary.net>, Jan Harkes <jaharkes@cs.cmu.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010321172800.A11353@comp.nus.edu.sg> <200103210951.f2L9pot18383@webber.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200103210951.f2L9pot18383@webber.adilger.int>; from adilger@turbolinux.com on Wed, Mar 21, 2001 at 02:51:49AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Lastly, which cache can be reclaimed, and which can't?
> 
> Slab cache will shrink if there are whole pages which are empty (it may
> be that they have to be at the end of the cache).  It is hard to tell
> from the above numbers if any of the caches could shrink, because it
> depends on the number of objects per page, and if there are any whole
> pages without allocated objects.


Btw, how to know the size of each objects in different cache?

-- 
Cheers!
--Zou Min 
