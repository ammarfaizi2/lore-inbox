Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135499AbRDSBMU>; Wed, 18 Apr 2001 21:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135501AbRDSBMK>; Wed, 18 Apr 2001 21:12:10 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:54157 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S135499AbRDSBLy>; Wed, 18 Apr 2001 21:11:54 -0400
Date: Wed, 18 Apr 2001 21:11:40 -0400
To: Daniel Phillips <phillips@nl.linux.org>
Cc: linux-kernel@vger.kernel.org, adilger@turbolinux.com,
        ext2-devel@lists.sourceforge.net
Subject: Re: Ext2 Directory Index - Delete Performance
Message-ID: <20010418211139.A11833@cs.cmu.edu>
Mail-Followup-To: Daniel Phillips <phillips@nl.linux.org>,
	linux-kernel@vger.kernel.org, adilger@turbolinux.com,
	ext2-devel@lists.sourceforge.net
In-Reply-To: <20010419002757Z92249-1659+3@humbolt.nl.linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010419002757Z92249-1659+3@humbolt.nl.linux.org>; from phillips@nl.linux.org on Thu, Apr 19, 2001 at 02:27:48AM +0200
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2001 at 02:27:48AM +0200, Daniel Phillips wrote:
> more memory.  If you have enough memory, the inode cache won't thrash,
> and even when it does, it does so gracefully - performance falls off
> nice and slowly.  For example, 250 Meg of inode cache will handle 2
> million inodes with no thrashing at all.

What inode cache are you talking about? According to the slabinfo output
on my machine every inode takes up 480 bytes in the inode_cache slab. So
250MB is only able to hold about half a million inodes in memory.

Jan

