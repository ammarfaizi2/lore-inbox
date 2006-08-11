Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbWHKWMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWHKWMI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 18:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbWHKWMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 18:12:08 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:22734 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964788AbWHKWMF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 18:12:05 -0400
Subject: aic7xxx broken in 2.6.18-rc3-mm2
From: Dave Hansen <haveblue@us.ibm.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux scsi <linux-scsi@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Alexis Bruemmer <alexisb@us.ibm.com>,
       Mike Anderson <andmike@us.ibm.com>
Content-Type: text/plain
Date: Fri, 11 Aug 2006 15:11:48 -0700
Message-Id: <1155334308.7574.50.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My scsi card stopped being detected in 2.6.18-rc3-mm2, but works in
plain 2.6.18-rc3.  I bisected all the way down to the git-sas.patch.  I
then noticed that if I enable the AIC94XX driver, my card works again.

I'm digging through it right now, but I figured I'd post in case anyone
else had seen this.  This error mode seems vaguely familiar as well.
Any ideas?

-- Dave

