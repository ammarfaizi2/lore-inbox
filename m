Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbUBDXR4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 18:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263927AbUBDXR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 18:17:56 -0500
Received: from brmx1.fl.icn.siemens.com ([12.147.96.32]:17628 "EHLO
	brmx1.fl.icn.siemens.com") by vger.kernel.org with ESMTP
	id S263596AbUBDXRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 18:17:54 -0500
Message-ID: <7A25937D23A1E64C8E93CB4A50509C2A0310F097@stca204a.bus.sc.rolm.com>
From: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
To: linux-kernel@vger.kernel.org
Subject: 
Date: Wed, 4 Feb 2004 15:17:45 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a question concerning the amount of memory assigned to a process. We
are using a 2.4 Kernel (SMP). We have a process which is started and tries
to do an MMAP on a 100MByte area. The mmap call fails with MAP_FAILED.
Decreasing the size of the memory requested by mmap to 50 Mbyte works
correctly. It seems as if the mmap call with 100Mbyte exceeds some sort of
memory limit assigned to this process.

The system is physically equipped with 4Gbytes of memory.

Any ideas why this fails?

Jack Bloch 
Siemens ICN
phone                (561) 923-6550
e-mail                jack.bloch@icn.siemens.com

