Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131363AbRBDOTl>; Sun, 4 Feb 2001 09:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131544AbRBDOTb>; Sun, 4 Feb 2001 09:19:31 -0500
Received: from selene.cps.intel.com ([192.198.165.10]:12551 "EHLO
	selene.cps.intel.com") by vger.kernel.org with ESMTP
	id <S131363AbRBDOTS>; Sun, 4 Feb 2001 09:19:18 -0500
Message-ID: <07E6E3B8C072D211AC4100A0C9C5758302B27119@hasmsx52.iil.intel.com>
From: "Hen, Shmulik" <shmulik.hen@intel.com>
To: "'LKML'" <linux-kernel@vger.kernel.org>
Subject: kernel memory allocations alignment
Date: Sun, 4 Feb 2001 06:19:03 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When using kmalloc(size_t size), do I get a guaranty that the memory region
allocated is aligned according to the size specified ?
More to the point, if I call kmalloc for type int on an IA64 architecture is
the pointer going to be 8 bytes aligned ?


	Shmulik Hen
	Software Engineer
	Linux Advanced Networking Services
	Network Communications Group, Israel (NCGj)
	Intel Corporation Ltd.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
