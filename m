Return-Path: <linux-kernel-owner+w=401wt.eu-S932663AbWLMRmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932663AbWLMRmr (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 12:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932652AbWLMRmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 12:42:47 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:3102 "EHLO
	pollux.ds.pg.gda.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932418AbWLMRmq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 12:42:46 -0500
X-Greylist: delayed 1938 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 12:42:46 EST
Date: Wed, 13 Dec 2006 17:10:22 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>, Antonino Daplas <adaplas@pol.net>
cc: linux-fbdev-devel@lists.sourceforge.net, axp-list@redhat.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.19 0/6] tgafb: Various fixes
Message-ID: <Pine.LNX.4.64N.0612131532320.24220@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

 In the course of adding support for the TURBOchannel bus to the tgafb 
driver I discovered and fixed a few problems and did a few cleanups.  
They form this series of patches.  I have tested them all successfully on 
an 8-plane and a 32-plane board, but they are both TURBOchannel options 
(ZLX-E1 and ZLX-E3, respectively).  I do not have any PCI TGA cards, so 
please anybody who cares about them and have suitable hardware do a little 
bit of testing.

  Maciej
