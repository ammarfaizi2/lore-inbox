Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264436AbTF0OuY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 10:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264450AbTF0OuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 10:50:23 -0400
Received: from d12lmsgate-5.de.ibm.com ([194.196.100.238]:13481 "EHLO
	d12lmsgate-5.de.ibm.com") by vger.kernel.org with ESMTP
	id S264436AbTF0OuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 10:50:20 -0400
Date: Fri, 27 Jun 2003 17:03:28 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 patches: description.
Message-ID: <20030627150328.GA3591@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
7 patches for s390.

Short descriptions:
1) Basic patch to get kernel working on s390 again.
2) Compat fixes for s390. 
3) Common i/o layer patch. Most important change is the option to
   enable/disable path grouping. It makes no sense to try path grouping
   on devices that don't support it. It is now the decision of the device
   driver to use path grouping or not.
4) Some dasd stuff. Nothing important.
5) Correct call to SET_MODULE_OWNER in the network device drivers.
6) Fix two typos in xpram.
7) Return 0 on success in tty3215_init.

Patches are against linux-bk as of 2003/06/27.

blue skies,
  Martin.

