Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267618AbTBLTGt>; Wed, 12 Feb 2003 14:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267645AbTBLTGt>; Wed, 12 Feb 2003 14:06:49 -0500
Received: from inmail.compaq.com ([161.114.64.102]:11538 "EHLO
	zmamail02.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S267618AbTBLTGq>; Wed, 12 Feb 2003 14:06:46 -0500
Date: Wed, 12 Feb 2003 13:17:13 +0600
From: steve cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: Re: [PATCH] 2.5.60 make cciss driver compile
Message-ID: <20030212071713.GF1032@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove unused variable from cciss_scsi.c
(patch 6 of 11)
-- steve

--- linux-2.5.60/drivers/block/cciss_scsi.c~rm_unused_var	2003-02-12 10:12:59.000000000 +0600
+++ linux-2.5.60-scameron/drivers/block/cciss_scsi.c	2003-02-12 10:12:59.000000000 +0600
@@ -1262,7 +1262,6 @@ cciss_scsi_proc_info(char *buffer, /* da
 
 	int buflen, datalen;
 	struct Scsi_Host *sh;
-	int found;
 	ctlr_info_t *ci;
 	int cntl_num;
 

_
