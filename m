Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266925AbUGMWLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266925AbUGMWLn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 18:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266924AbUGMWLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 18:11:25 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:57595 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266923AbUGMWLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 18:11:19 -0400
From: jmerkey@comcast.net
To: Hans Reiser <reiser@namesys.com>
Cc: Andi Kleen <ak@muc.de>, adilger@clusterfs.com,
       linux-kernel@vger.kernel.org
Subject: [UPDATE REPORT] Ext3 File System "Too many files" with snort
Date: Tue, 13 Jul 2004 22:11:15 +0000
Message-Id: <071320042211.16027.40F45E03000AF97700003E9B2200734840970A059D0A0306@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Jun 24 2004)
X-Authenticated-Sender: am1lcmtleUBjb21jYXN0Lm5ldA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I applied both the ext3 htree patches and a system using Reiser FS with snort 
running with 30,000+ (actually as high s 70,000+) addresses being generated 
from one of the systems with snort 2.1.3.  I am not able to get the second system out until next week since the customer has to put in a change order, so I tested with a system at only one of the customer sites with ext3 and reiser in very contained manner,  Both the Native Reiser FS and ext3 with the patch seem to work fine on this system with an updated kernel and by creating an isolated ext3 partition and ReiserFS partition on the system.  Thanks for the help to Hans and Andreas.    

Looks fixed. 

Jeff





