Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267457AbTB1Eep>; Thu, 27 Feb 2003 23:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267472AbTB1Eep>; Thu, 27 Feb 2003 23:34:45 -0500
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:50078 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S267457AbTB1Eeo>;
	Thu, 27 Feb 2003 23:34:44 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-ck4
Date: Fri, 28 Feb 2003 15:45:01 +1100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302281545.01222.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've updated my patchset

It includes:
O(1) scheduler
Preempt
Low Latency
AA VM addons
Read Latency2
SuperMount
XFS
ACPI
DVD/CDRW packet writing
Desktop Tuning
optional extras:
Compressed caching
Rmap15d

Changes since ck3:
Supermount bug which caused random hangs has been quenched
AA VM has been updated to latest available
Packet writing for cdrw/dvd has been added
Rmap patch is now a patch which can be applied to the full ck4 patch which 
rips out the aa vmversion

Known bugs:
Accounting bug in supermount causes harmless error on shutdown.

It can be found here:
http://kernel.kolivas.org
Domain name has changed sorry :-(

Please test carefully, especially the new features as I don't have the 
resources to test them out.

Feel free to contact me with suggestions, questions, comments, patches and 
requests

Con
