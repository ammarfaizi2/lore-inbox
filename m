Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267696AbTBGEK4>; Thu, 6 Feb 2003 23:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267690AbTBGEKz>; Thu, 6 Feb 2003 23:10:55 -0500
Received: from dp.samba.org ([66.70.73.150]:61383 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267638AbTBGEKx>;
	Thu, 6 Feb 2003 23:10:53 -0500
Date: Fri, 7 Feb 2003 15:19:36 +1100
From: Anton Blanchard <anton@samba.org>
To: Patrick Mansfield <patmans@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       James Bottomley <James.Bottomley@steeleye.com>, mikeand@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc: andmike@us.ibm.com
Subject: Re: Broken SCSI code in the BK tree (was: 2.5.59-mm8)
Message-ID: <20030207041936.GA26189@krispykreme>
References: <211570000.1044508407@[10.10.2.4]> <265170000.1044564655@[10.10.2.4]> <275930000.1044570608@[10.10.2.4]> <1044573927.2332.100.camel@mulgrave> <20030206172434.A15559@beaverton.ibm.com> <293060000.1044583265@[10.10.2.4]> <20030206182502.A16364@beaverton.ibm.com> <20030206230544.E19868@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030206230544.E19868@redhat.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> If I understand correctly, Matthew Jacob's latest isp driver set drives
> *all* qlogic hardware (or at least all the older stuff like the qlogicisp
> driver drives).  I would much prefer that people simply test out Matthew's
> driver and use it instead.  In fact, if it's ready for 2.5 kernel use, I
> would strongly recommend that it be considered as a possible replacement
> in the linux kernel for the default driver on all qlogic cards not handled
> by the new qla2x00 driver version 6 (DaveM may have objections to that 
> related to sparc if Matthew's driver isn't sparc friendly, but I don't 
> know of any other reason not to switch over).

I had a bunch of problems with the in kernel and vendor qlogic drivers
on my ppc64 box. Matt Jacob's driver worked out of the box. Davem
sounded positive last time I asked him about it.

I did a quick forward port to 2.5 a month or two ago, sounds like we
should work to get it in the kernel. There are some rough edges but
Mike kindly offered to lend a hand here.

Anton
