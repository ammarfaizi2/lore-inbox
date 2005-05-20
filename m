Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbVETWLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVETWLZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 18:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbVETWLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 18:11:25 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.59]:35476 "EHLO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261426AbVETWLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 18:11:22 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Adam Miller <amiller@gravity.phys.uwm.edu>
Date: Sat, 21 May 2005 08:11:14 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17038.24706.571479.471268@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: software RAID
In-Reply-To: message from Adam Miller on Friday May 20
References: <Pine.LNX.4.62.0505201246520.13530@gannon.phys.uwm.edu>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday May 20, amiller@gravity.phys.uwm.edu wrote:
> Hi,
>    We're looking to set up either software RAID 1 or RAID 10 using 2 SATA 
> disks.  If a disk in drive A has a bad sector, can it be setup so that the 
> array will read the sector from drive B and then have it rewrite the 
> bad sector on drive A?  Please CC me in the response.

Not yet, but it is this functionality is very near the top of my TODO
list for md.

NeilBrown
