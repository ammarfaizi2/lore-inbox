Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313075AbSDSVkK>; Fri, 19 Apr 2002 17:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313054AbSDSVkJ>; Fri, 19 Apr 2002 17:40:09 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:18166 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S313075AbSDSVkJ>; Fri, 19 Apr 2002 17:40:09 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Fri, 19 Apr 2002 15:38:35 -0600
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: unresolved symbol: __udivdi3
Message-ID: <20020419213835.GA559@turbolinux.com>
Mail-Followup-To: Ben Greear <greearb@candelatech.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3CC08632.8020102@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 19, 2002  14:03 -0700, Ben Greear wrote:
> I would like to be able to devide 64bit numbers in a kernel module,
> but I get unresolved symbols when trying to insmod.
> 
> Does anyone have any ideas how to get around this little issue
> (without the obvious of casting the hell out of all my __u64s
> when doing division and throwing away precision.)?

When you talk about precision, it makes me think you want to have
a floating-point divide.  In fact, no floating-point math can be
done in the kernel.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

