Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270877AbTGVRVV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 13:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270883AbTGVRVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 13:21:21 -0400
Received: from ns2.len.rkcom.net ([80.148.32.9]:59542 "EHLO ns2.len.rkcom.net")
	by vger.kernel.org with ESMTP id S270877AbTGVRVU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 13:21:20 -0400
From: Florian Schanda <ma1flfs@bath.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Strange lockup during boot in 2.4.21-xfs and 2.6.0-test1
Date: Tue, 22 Jul 2003 19:35:51 +0000
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307221935.51292.ma1flfs@bath.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I sometimes get this strange bug with my new system (Dual Xeon 2.4Ghz on Tyan 
Tiger motherboard; Intel E7505 chipset): During boot it just hangs with the 
following message: (The last few lines only, as I had to write it down on 
paper...)

...
Intel machine check reporting on CPU#1
CPU1: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
Booting processor 2/6 eip 2000
Initializing CPU#2
masked ExtINT on CPU#2
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
calibrating delay loop... 4771.02 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical processor ID: 3
Intel machine check reporting on CPU#2
CPU2: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
Booting processor 3/7 eip 2000

and then it hangs. The only option is the reset button. (This particular one 
was with kernel 2.4.21-xfs, but looks similar with 2.6.0-test1)

This does not happen always, only sometimes. (like 25% of all boots)

Is there anything I could to to help debug this?

Thanks in advance,

	Florian

