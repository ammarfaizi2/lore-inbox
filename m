Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbUCRG2g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 01:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbUCRG2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 01:28:36 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:1013 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261664AbUCRG2f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 01:28:35 -0500
Date: Thu, 18 Mar 2004 12:03:06 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Carsten Otte <COTTE@de.ibm.com>,
       Christian Borntraeger <CBORNTRA@de.ibm.com>,
       "Martin J. Bligh" <mjbligh@us.ibm.com>, Matt Mackall <mpm@selenic.com>
Subject: [RFC 0/6] sysfs backing store v0.3
Message-ID: <20040318063306.GA27107@in.ibm.com>
Reply-To: maneesh@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please find the following patch set for sysfs backing store. Thanks to Carsten 
Otte and S390 Linux guys for reporting the bug while unloading zfcp driver. 

Please see the previous posting for more details and numbers
http://marc.theaimsgroup.com/?l=linux-kernel&m=107589464818859&w=2

Changes in Version 0.3
----------------------
o Fixed dentry ref counting for un-named attribute groups. Because of this
  zfcp driver was not getting unloaded waiting for the dentry ref. count to
  go away.

Details of code changes are mentioned in the respective patches. Patch set
is against 2.6.5-rc1. 

Al, it will be great help if you can spare some time in reviewing this.

Thanks
Maneesh

-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-25268553
T/L : 9243696
