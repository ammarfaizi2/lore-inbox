Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbTEFXyP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 19:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbTEFXyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 19:54:15 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:13255 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S261863AbTEFXyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 19:54:14 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Wakko Warner <wakko@animx.eu.org>
Date: Wed, 7 May 2003 10:06:18 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16056.19962.192303.994466@notabene.cse.unsw.edu.au>
Cc: viro@parcelfarce.linux.theplanet.co.uk,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Ezra Nugroho <ezran@goshen.edu>, linux-kernel@vger.kernel.org
Subject: Re: partitions in meta devices
In-Reply-To: message from Wakko Warner on Monday May 5
References: <1052153060.29588.196.camel@ezran.goshen.edu>
	<3EB693B1.9020505@gmx.net>
	<1052153834.29676.219.camel@ezran.goshen.edu>
	<3EB69883.8090609@gmx.net>
	<20030505191604.GC10374@parcelfarce.linux.theplanet.co.uk>
	<20030505173839.A22502@animx.eu.org>
X-Mailer: VM 7.14 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday May 5, wakko@animx.eu.org wrote:
> > > OK. Maybe I wasn't clear enough.
> > > 1. Partition a drive
> > > 2. Reboot
> > > 3. Now the kernel should see the partitions and let you create file
> > > systems on them.
> > > 
> > > You rebooted and fdisk sees the partitions now. Fine. Please try to
> > > mke2fs /dev/md0p1
> > > That should work. If it doesn't, devfs could be the problem.
> > 
> > 	No, it should not.  And devfs, for once, has nothing to do with it.
> > RAID devices (md*) have _one_ (1) minor allocated to each.  Consequently,
> > they could not be partitioned by any kernel - there is no device numbers
> > to be assigned to their partitions.
> >  
> > > Could you please tell us which kernel version you're using?
> > 
> > 	What would be much more interesting, which kernel are _you_ using
> > and what device numbers, in your experience, do these partitions get?
> 
> I recall an MdPart patch for the kernel that would allow this, however, it
> was way too buggy for real use.  google for mdpart.

Unreported bugs don't get fixed ... or did I miss your report?

Work great for me on most of my servers.

NeilBrown
