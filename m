Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266850AbUBRM62 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 07:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266879AbUBRM62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 07:58:28 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:13025 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S266850AbUBRM5p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 07:57:45 -0500
Date: Wed, 18 Feb 2004 18:32:11 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mjbligh@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Matt Mackall <mpm@selenic.com>,
       Christian Borntraeger <CBORNTRA@de.ibm.com>
Subject: [RFC][0/6] Sysfs backing store release 0.1
Message-ID: <20040218130211.GB1255@in.ibm.com>
Reply-To: maneesh@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Please find the following patch set for latest version of sysfs backing store. 
I decided to give version number starting from this release expecting more 
changes based on the comments I hope to get. Please note as I am also hoping 
that Andrew may put this first in -mm, this version applies on top on 2.6.3-mm1.
I do have same patch set for mainline, readily available.

Please refer to previous posting for more details/numbers etc
  http://marc.theaimsgroup.com/?l=linux-kernel&m=107589464818859&w=2

Changes in 0.1
--------------
o Corrected locking in sysfs_umount_begin(), in sysfs-leaves-mount.patch. 
  Thanks to Andrew, for pointing this out.
o Re-diffed all the six patches for 2.6.3-mm1.

Al, it would be great help if you can spare some time in reviewing this.

Thanks
Maneesh


-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-5268553
T/L : 9243696
