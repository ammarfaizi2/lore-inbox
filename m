Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131334AbRCHLqc>; Thu, 8 Mar 2001 06:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131333AbRCHLqW>; Thu, 8 Mar 2001 06:46:22 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:45808 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S131336AbRCHLqL>; Thu, 8 Mar 2001 06:46:11 -0500
Date: Thu, 8 Mar 2001 17:14:07 +0530
From: Maneesh Soni <smaneesh@in.ibm.com>
To: lse tech <lse-tech@lists.sourceforge.net>
Cc: lkml <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
        Keith Owens <kaos@ocs.com.au>, Rusty Russell <rusty@linuxcare.com.au>,
        Mortan Andrew Mortan <andrewm@uow.edu.au>,
        "A. N. Kuznetsov" <kuznet@ms2.inr.ac.ru>,
        Miller David Miller <davem@redhat.com>
Subject: [Patch] Module Unloading using Read-Copy-Update
Message-ID: <20010308171407.A5594@in.ibm.com>
Reply-To: smaneesh@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,
 
In this post I would like to submit a patch providing a two phase cleanup logic
for solving the module unloading races in linux. It uses the deferred update
interface provided by the Read-Copy-Update mechanism. A patch with 
implementation of Read-Copy-Update on linux has been posted earlier on lkml and 
lse-tech by Dipankar Sarma
   http://marc.theaimsgroup.com/?l=lse-tech&m=98292649600654&w=2
 
In this first version of the new cleanup logic, I have tried to keep the changes lesser. Please download the patch and a readme along with a few testcases from
 
   http://lse.sourceforge.net/locking/module_unloading-2.4.1-0.1.tar.gz
 
 
Thank you,
Maneesh
 
--
Maneesh Soni
Linux Technology Center,
IBM Software Labs, Bangalore, INDIA
Phone: +91-80-5262355 Extn: 2717                                                 
-- 
