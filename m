Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbVBIJKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbVBIJKR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 04:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVBIJKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 04:10:09 -0500
Received: from AToulouse-105-1-1-197.w80-14.abo.wanadoo.fr ([80.14.91.197]:50931
	"EHLO lexbox.fr") by vger.kernel.org with ESMTP id S261450AbVBIJJy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 04:09:54 -0500
Subject: BUG libata: SATA controller BigEndian
Date: Wed, 9 Feb 2005 10:10:28 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <17AB476A04B7C842887E0EB1F268111E015180@xpserver.intra.lexbox.org>
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
X-MS-TNEF-Correlator: 
Thread-Topic: BUG libata: SATA controller BigEndian
thread-index: AcUOhzLqJbksfw9IRCOSBLXiQsXowA==
From: "David Sanchez" <david.sanchez@lexbox.fr>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On my embedded system, I'm using the kernel2.6.10 plus the libata patch
2.6.11 of Mister Garzik.

In little endian mode, all is ok i.e all my hdd connected on the
controller
SATA (Promise PDC20371 or PDC20579) are recognized.

Unfortunately when I switch to big endian mode, my hdd are no more
recognized and I get message such as "dev 0 not supported, ignoring" or
just
"no device found" !

Does everyone encouter such a problem ? And do you find a solution :) ?

Thanks

David Sanchez 


