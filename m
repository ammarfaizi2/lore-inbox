Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263290AbSJ3NBm>; Wed, 30 Oct 2002 08:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263330AbSJ3NBm>; Wed, 30 Oct 2002 08:01:42 -0500
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:56205 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S263290AbSJ3NBl>; Wed, 30 Oct 2002 08:01:41 -0500
Date: Wed, 30 Oct 2002 07:28:38 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: Samuel Flory <sflory@rackable.com>, linux-kernel@vger.kernel.org
Subject: Re: ANNOUNCEMENT: Squashfs released (a highly compressed filesystem)
Message-ID: <20021030072838.A628@nightmaster.csn.tu-chemnitz.de>
References: <3DBF43ED.70001@lougher.demon.co.uk> <3DBF4DBA.8060005@rackable.com> <3DBF5756.2010702@lougher.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3DBF5756.2010702@lougher.demon.co.uk>; from phillip@lougher.demon.co.uk on Wed, Oct 30, 2002 at 03:51:50AM +0000
X-Spam-Score: -14.5 (--------------)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *186sZp-0002yq-00*WAVnW1HIeCg*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2002 at 03:51:50AM +0000, Phillip Lougher wrote:
> 4.  Full 32 bit uids/guids are stored (4 bits stored in inode, uses a 
> lookup table, to give 48 uids/16 gids).  File sizes upto 2^32 are 
> supported.  Timestamp info is stored. Cramfs truncates uids to 16 bits, 
> uids to 8 bits.  Cramfs files sizes are upto 2^24.  No timestamp info. 
> Squashfs takes advantage of metadata compression to have more info with 
> smaller metadata overhead.

Why limiting to 2GB? AFAIR you wanted to use a cramfs-like
filesystem for backups. Are videos and large data bases not worth
of backing up?

It seems to be good work. So I really wait for Al Viros comments ;-)

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
