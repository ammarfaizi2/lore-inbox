Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263653AbTLaMoq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 07:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264461AbTLaMoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 07:44:46 -0500
Received: from mail3.ithnet.com ([217.64.64.7]:53679 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S263653AbTLaMon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 07:44:43 -0500
X-Sender-Authentication: net64
Date: Wed, 31 Dec 2003 13:44:41 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel@vger.kernel.org
Subject: Problem with SYM53C8XX SCSI support in 2.4.23
Message-Id: <20031231134441.5045155f.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

does anybody know if the following messages point to a broken controller or drive or some other reason:

Dec 30 01:20:30 box kernel: sym53c1010-33-0:0: ERROR (81:0) (8-af-80) (3e/18) @ (script 50:f31c0004).
Dec 30 01:20:30 box kernel: sym53c1010-33-0: script cmd = 90080000
Dec 30 01:20:30 box kernel: sym53c1010-33-0: regdump: da 10 80 18 47 3e 00 0e 00 08 80 af 00 00 07 02 01 00 00 00 0a 00 00 00.
Dec 30 01:20:30 box kernel: sym53c1010-33-0: ctest4/sist original 0x8/0x0  mod: 0x18/0x0
Dec 30 01:20:30 box kernel: sym53c1010-33-0: Downloading SCSI SCRIPTS.
Dec 30 01:20:57 box kernel: sym53c1010-33-0:0: ERROR (81:0) (8-af-80) (3e/18) @ (script 50:f31c0004).
Dec 30 01:20:57 box kernel: sym53c1010-33-0: script cmd = 90080000
Dec 30 01:20:57 box kernel: sym53c1010-33-0: regdump: da 10 80 18 47 3e 00 0e 00 08 80 af 00 00 07 02 01 00 00 00 0a 00 00 00.
Dec 30 01:20:57 box kernel: sym53c1010-33-0: ctest4/sist original 0x8/0x0  mod: 0x18/0x0
Dec 30 01:20:57 box kernel: sym53c1010-33-0: Downloading SCSI SCRIPTS.   
Dec 30 01:49:30 box kernel: sym53c1010-33-0:0: ERROR (81:0) (8-0-0) (3e/18) @ (script 50:f31c0004).
Dec 30 01:49:30 box kernel: sym53c1010-33-0: script cmd = 90080000
Dec 30 01:49:30 box kernel: sym53c1010-33-0: regdump: da 00 00 18 47 3e 00 0f 00 08 80 00 00 00 07 02 01 00 00 00 02 00 00 00.
Dec 30 01:49:30 box kernel: sym53c1010-33-0: ctest4/sist original 0x8/0x0  mod: 0x18/0x0
Dec 30 01:49:30 box kernel: sym53c1010-33-0: Downloading SCSI SCRIPTS.

There is no heavy action going on during this time. The hardware worked for flawlessly for years.

Regards,
Stephan
