Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263769AbUIINdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbUIINdd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 09:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263770AbUIINdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 09:33:33 -0400
Received: from web11509.mail.yahoo.com ([216.136.129.46]:34139 "HELO
	web11509.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263769AbUIINd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 09:33:29 -0400
Message-ID: <20040909133328.69682.qmail@web11509.mail.yahoo.com>
Date: Thu, 9 Sep 2004 06:33:28 -0700 (PDT)
From: Anil Kumar Prasad <anil_411@yahoo.com>
Subject: unexported tlb_flush_* routines in 2.6 on ppc64
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was trying to get my 2.4 module code working on 2.6
ppc64 (2.6.5-7.97 kernel provided by SUSE/distribution
SLES9). It seems tlb_flush routines are no longer
exported for module usage. Same is the case with 2.6.8
ppc64 kernel.

ppc64 #defines tlb_flush routines to flush_tlb_pending
(which needs __flush_tlb_pending). It also needs
per_cpu__ppc64_tlb_batch data.

I could see tlb_flush routines still exported on all
other  platforms. Is there any reason for un-exporting
it on ppc64?


There used to be a ppc64-devel mailing list at
lists.linuxppc.org but its no longer accessible. Does
anyone know its current location?


Thanks,
Anil.

PS: Please put me on cc as I am not subscribed to this list.


	
		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
http://promotions.yahoo.com/new_mail 
