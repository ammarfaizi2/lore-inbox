Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263060AbTCNNUi>; Fri, 14 Mar 2003 08:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263085AbTCNNUi>; Fri, 14 Mar 2003 08:20:38 -0500
Received: from uni00du.unity.ncsu.edu ([152.1.13.100]:34432 "EHLO
	uni00du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id <S263060AbTCNNUh>; Fri, 14 Mar 2003 08:20:37 -0500
From: jlnance@unity.ncsu.edu
Date: Fri, 14 Mar 2003 08:31:26 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.64-mm6
Message-ID: <20030314133126.GB2679@ncsu.edu>
References: <20030313032615.7ca491d6.akpm@digeo.com> <1047572586.1281.1.camel@ixodes.goop.org> <20030313113448.595c6119.akpm@digeo.com> <1047611104.14782.5410.camel@spc1.mesatop.com> <20030313192809.17301709.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030313192809.17301709.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 13, 2003 at 07:28:09PM -0800, Andrew Morton wrote:

> One subtlety: the linker (ld) lays files out very poorly.  So the prefaulting
> trick will not help much when run against an executable which was written by
> ld.  But if you've copied it into /bin (make install) then it will work well.
> That's something to watch out for.

Andrew,
    I am not sure what you mean by this.  Are you saying that the way ld
accesses files causes the blocks on the disk to be layed out poorly?
That is the only thing I can think of that would get fixed by copying.

Thanks,

Jim
