Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284373AbRLCIvs>; Mon, 3 Dec 2001 03:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284387AbRLCIt5>; Mon, 3 Dec 2001 03:49:57 -0500
Received: from baltic.usna.edu ([131.122.220.21]:12209 "EHLO baltic.usna.edu")
	by vger.kernel.org with ESMTP id <S284326AbRLBWcv>;
	Sun, 2 Dec 2001 17:32:51 -0500
Subject: Possible bugs
From: MIDN Sean Jones <m053546@usna.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 02 Dec 2001 17:29:52 -0500
Message-Id: <1007332194.11790.0.camel@Eagle.usna.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was looking for code to cleanup and found these warnings:

(from 2.4.17-pre2)

dmi_scan.c:195: warning: `disable_ide_dma' defined but not used
agpgart_be.c:524: warning: `agp_generic_create_gatt_table' defined but
not used
agpgart_be.c:652: warning: `agp_generic_free_gatt_table' defined but not
used
agpgart_be.c:700: warning: `agp_generic_insert_memory' defined but not
used
agpgart_be.c:758: warning: `agp_generic_remove_memory' defined but not
used
parport_pc.c:1784: warning: `parport_ECP_supported' defined but not used

Are these functions supposed to be there or are they leftovers from
previous modifications.

Thanks,

Sean Jones

