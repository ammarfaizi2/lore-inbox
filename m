Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262718AbVBCQXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262718AbVBCQXw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 11:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262395AbVBCQXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 11:23:52 -0500
Received: from zetaATTfw.zai.com ([12.47.112.36]:38414 "EHLO
	danube.rivers.zai.com") by vger.kernel.org with ESMTP
	id S263650AbVBCQWh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 11:22:37 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: PPC64 - missing mem=xxx parameter parsing
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Thu, 3 Feb 2005 11:23:56 -0500
Message-ID: <6308A50BEE83C844BEEF5CCB349695450A7E32@danube.rivers.zai.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PPC64 - missing mem=xxx parameter parsing
Thread-Index: AcUKDMI+FS/Orby8S82cthIv+GwguQ==
From: "Sanders, Rob M." <sanders-rob@zai.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
  I'm trying to port a device driver that works under 32 bit linux (both
ppc and x86)
to ppc64.  The driver expected the memory on the system to be
partitioned using the
'mem=xxx' boot parameter settings such that linux use the lower xxx and
remaining 
physical memory was treated as a contiguous ramdisk, with the driver
handling the
file-system related details.  The 'mem=' option does not exist under
ppc64, and
I was wondering what would break if I copied the appropriate ports of
arch/ppc/mm/init.c
into arch/ppc64/mm/init.c  Any ideas?
  Please cc me on any replies....

							Rob
