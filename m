Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269182AbUIQW2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269182AbUIQW2e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 18:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269085AbUIQW1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 18:27:33 -0400
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:23558 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S269065AbUIQWXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 18:23:47 -0400
Date: Fri, 17 Sep 2004 17:23:13 -0500
From: mike.miller@hp.com
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Subject: MSI in 2.6.9-rc2-mm1 kernel
Message-ID: <20040917222313.GA19679@beardog.cca.cpqcorp.net>
Reply-To: mikem@beardog.cca.cpqcorp.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has anyone tried an MSI capable device in 2.6.9-rc2-mm1? When intializing my
MSI capable controller I get a return value of zero from pci_enable_msi but
the system hangs at that point as if I'm not getting the MSI vector.

Just started looking at this, but I was wondering if anyone else has seen this?

BTW: I also see a console message "MSI INIT SUCCESS" before the hang.

Thanks,
mikem
