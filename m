Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbTIVKIt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 06:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbTIVKIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 06:08:49 -0400
Received: from ns2.len.rkcom.net ([80.148.32.9]:49339 "EHLO ns2.len.rkcom.net")
	by vger.kernel.org with ESMTP id S262767AbTIVKIs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 06:08:48 -0400
From: Florian Schanda <ma1flfs@bath.ac.uk>
Reply-To: ma1flfs@bath.ac.uk
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test5-mm4
Date: Mon, 22 Sep 2003 13:09:53 +0100
User-Agent: KMail/1.5.4
References: <20030922013548.6e5a5dcf.akpm@osdl.org>
In-Reply-To: <20030922013548.6e5a5dcf.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309221309.53310.ma1flfs@bath.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 September 2003 09:35, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test5/2

Hi,

I need this patch to compile ide modules properly.

	Florian

--- old/drivers/block/ll_rw_blk.c       2003-09-22 12:59:39.000000000 +0100
+++ linux-2.6.0-test5/drivers/block/ll_rw_blk.c 2003-09-22 13:01:46.000000000 
+0100
@@ -2903,3 +2903,4 @@
 EXPORT_SYMBOL(blk_run_queues);
 
 EXPORT_SYMBOL(blk_rq_bio_prep);
+EXPORT_SYMBOL(blk_rq_prep_restart);

