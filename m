Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272682AbTG1Gv3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 02:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272683AbTG1Gv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 02:51:29 -0400
Received: from web20203.mail.yahoo.com ([216.136.226.58]:30056 "HELO
	web20203.mail.yahoo.com") by vger.kernel.org with SMTP
	id S272682AbTG1Gv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 02:51:26 -0400
Message-ID: <20030728070639.8611.qmail@web20203.mail.yahoo.com>
Date: Mon, 28 Jul 2003 00:06:39 -0700 (PDT)
From: Raghava Vatsavayi <rajuraghava@yahoo.com>
Subject: DMA Mapping???
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Our ethernet driver performance is not so good in
powerpc machines. I have attached a link for a patch
and brief description below, which talks about 
alignment of dma memory for rx and tx buffers. 
So my question is, Will there be increase in 
performance on powerpc machines if I also align my 
tx/rx dma pointers?????



Description:
PCI bridge peculiarities mean the insufficiently
aligned DMAs perform terribly on Power4 hardware. This
hack copies and realigns packets to improve
performance.  
 

http://oss.software.ibm.com/linux/patches/?patch_id=881


Please mail me at rajuraghava@yahoo.com

Cheers
Raghav.



__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
