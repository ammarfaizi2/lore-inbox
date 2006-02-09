Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWBIUNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWBIUNN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 15:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWBIUNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 15:13:13 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:51404 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750755AbWBIUNM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 15:13:12 -0500
Subject: [ANNOUNCE] libhugetlbfs
From: Adam Litke <agl@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: "ADAM G. LITKE [imap]" <agl@us.ibm.com>,
       David Gibson <david@gibson.dropbear.id.au>, wli@holomorphy.com
Content-Type: text/plain
Organization: IBM
Date: Thu, 09 Feb 2006 14:12:55 -0600
Message-Id: <1139515975.21667.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Announcing libhugetlbfs -- A library to provide easier access to
hugetlbfs.

Adam Litke and David Gibson began work on this library to enable
applications to benefit from using hugetlb pages in a transparent way
and without source-level modifications.  We'd like to see this become
the focal point for userspace development and are interested in
integrating other functionality beyond what's listed below. 

Currently supported uses:
 - Transparent hugetlb-backed malloc
 - Remapping ELF program segments into hugetlb pages

See the HOWTO included in the distribution for usage instructions.

Git tree: git://ozlabs.org/~dgibson/git/libhugetlbfs.git
Sourceforge project page: http://sourceforge.net/projects/libhugetlbfs

Comments, suggestions and patches welcome.
-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

