Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262757AbTIVCvn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 22:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbTIVCvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 22:51:43 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:20492
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S262757AbTIVCvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 22:51:42 -0400
Subject: [ANNOUNCE]  slab information utility
From: Chris Rivera <cmrivera@ufl.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=iso-8859-13
Message-Id: <1064199786.1199.29.camel@boobies.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Sun, 21 Sep 2003 23:03:06 -0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love and I would like to announce the release of a new procps
utility, slabtop.  Slabtop displays detail kernel slab layer information
in real time.  The look of slabtop matches top's.  Slabtop displays a
statistics header along with the ´top¡ caches based on a sort criteria. 
Sample output of slabtop is as follows:

Active / Total Objects (% used)    : 42403 / 63315 (67.0%)
Active / Total Slabs (% used)      : 3461 / 3461 (100.0%)
Active / Total Caches (% used)     : 60 / 97 (61.9%)
Active / Total Size (% used)       : 10151.11K / 14245.87K (71.3%)
Minimum / Average / Maximum Object : 0.02K / 0.22K / 128.00K
                                                                                
  OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
 14000   7390  52%    0.07K    280       50      1120K size-64
 10528   5280  50%    0.26K    752       14      3008K dentry_cache
  9660   8602  89%    0.12K    322       30      1288K pte_chain
  8368   4913  58%    0.47K   1046        8      4184K ext3_inode_cache
  3300   3143  95%    0.07K     66       50       264K vm_area_struct
  3190   1089  34%    0.06K     55       58       220K buffer_head
  3024   2924  96%    0.04K     36       84       144K size-32
  2506   1982  79%    0.27K    179       14       716K radix_tree_node
  1782   1750  98%    0.14K     66       27       264K filp
   891    864  96%    0.14K     33       27       132K size-128
   869    862  99%    0.33K     79       11       316K inode_cache
   318    274  86%    0.07K      6       53        24K bio
   305    256  83%    0.06K      5       61        20K biovec-4
   288    281  97%    0.02K      2      144         8K biovec-1
   266    256  96%    0.20K     14       19        56K biovec-16
   260    256  98%    0.76K     52        5       208K biovec-64

I hope this tool will be of some use to all kernel developers.  Robert
has made procps packages available here:

http://www.tech9.net/rml/procps/

All bug reports and feature requests are welcome.  Hopefully, slabtop
will save the day.

Chris

