Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbUCCMeb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 07:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbUCCMeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 07:34:31 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:65213 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261582AbUCCMe3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 07:34:29 -0500
Date: Wed, 3 Mar 2004 18:08:58 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Greg KH <greg@kroah.com>,
       "Martin J. Bligh" <mjbligh@us.ibm.com>, Matt Mackall <mpm@selenic.com>,
       Christian Borntraeger <CBORNTRA@de.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Dipankar Sarma <dipankar@in.ibm.com>
Subject: [RFC] 0/6 sysfs backing store version 0.2
Message-ID: <20040303123858.GC2469@in.ibm.com>
Reply-To: maneesh@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Following patch set has the sysfs backing store version 0.2. Thanks to
John Stulz, Martin Bligh, Christian Borntraeger, Carsten Otte for testing 
out the patch set and reporting problems. 

Please refer to previous posting for more details/numbers etc
  http://marc.theaimsgroup.com/?l=linux-kernel&m=107589464818859&w=2


Changes in version 0.2
----------------------
o fixed d_move panic as found by John Stulz/Martin Bligh
o fixed errors during "ls -la /sys/devices/qeth/0.0.f5ed" as found by Carsten
  Otte & Christian Borntraeger on S390.
o Miscellaneous error checking corrections.

Details of the coded changes are mentioned in respective patches. Patch
set is against 2.6.4-rc1. As usual code review, suggestions, bug reports 
are eagerly awaited.

Thanks
Maneesh

-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-5268553
T/L : 9243696
