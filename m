Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131293AbRCUJ3x>; Wed, 21 Mar 2001 04:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131296AbRCUJ3n>; Wed, 21 Mar 2001 04:29:43 -0500
Received: from x86unx3.comp.nus.edu.sg ([137.132.90.2]:56789 "EHLO
	x86unx3.comp.nus.edu.sg") by vger.kernel.org with ESMTP
	id <S131293AbRCUJ3e>; Wed, 21 Mar 2001 04:29:34 -0500
Date: Wed, 21 Mar 2001 17:28:00 +0800
From: Zou Min <zoum@comp.nus.edu.sg>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Josh Grebe <squash@primary.net>, Jan Harkes <jaharkes@cs.cmu.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: Question about memory usage in 2.4 vs 2.2
Message-ID: <20010321172800.A11353@comp.nus.edu.sg>
Mail-Followup-To: Zou Min <zoum@comp.nus.edu.sg>,
	Rik van Riel <riel@conectiva.com.br>,
	Josh Grebe <squash@primary.net>, Jan Harkes <jaharkes@cs.cmu.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0103201403440.2405-100000@scarface.primary.net> <Pine.LNX.4.21.0103201857170.3750-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0103201857170.3750-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on Tue, Mar 20, 2001 at 07:18:43PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > slabinfo reports:
> > 
> > inode_cache       189974 243512    480 30439 30439    1 :  124   62
> > dentry_cache      201179 341940    128 11398 11398    1 :  252  126
>                                       ^
>   <name>            <used> <allocd>   |  <used> <allocd>
>                      <in objects>  <size>   <in pages>
> 

Then how to interpret slabinfo in 2.2.16 box? 
e.g. grep cache /proc/slabinfo

kmem_cache            32     42
skbuff_head_cache   2676   2730
dentry_cache       15626  16988
files_cache          103    108
uid_cache             10    127
slab_cache            85    126
what does those numbers mean?

Furthermore, are those cache info above reported as part of the total
cache in /proc/meminfo ? 

Lastly, which cache can be reclaimed, and which can't?

I am doing some memory measurements in 2.2.16 linux box. Thanks in advance!

-- 
Cheers!
--Zou Min 

