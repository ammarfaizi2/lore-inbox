Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263867AbTEFR3t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 13:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263871AbTEFR3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 13:29:49 -0400
Received: from murphys.services.quay.plus.net ([212.159.14.225]:33154 "HELO
	murphys.services.quay.plus.net") by vger.kernel.org with SMTP
	id S263867AbTEFR3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 13:29:48 -0400
From: "Riley Williams" <Riley@Williams.Name>
To: "Nicolas Pitre" <nico@cam.org>, "Russell King" <rmk@arm.linux.org.uk>
Cc: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       "Marcus Meissner" <meissner@suse.de>,
       "lkml" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Only use MS-DOS-Partitions by default on X86
Date: Tue, 6 May 2003 18:42:47 +0100
Message-ID: <BKEGKPICNAKILKJKMHCAMEMNCKAA.Riley@Williams.Name>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-reply-to: <Pine.LNX.4.44.0305061320080.11648-100000@xanadu.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas.

 >> Maybe introducing a CONFIG_DISK option and making partitioning
 >> as a whole depend on that ?

 > According to Alan it's nearly possible to configure the block
 > layer out entirely, which would be a good thing to associate
 > with a CONFIG_DISK option too.

If we're killing the entire block layer, why call it CONFIG_DISK ???
Surely CONFIG_BLOCK_DEV would be much more appropriate? I certainly
don't think of my SmartMedia flash cards as disks...

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.476 / Virus Database: 273 - Release Date: 24-Apr-2003

