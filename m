Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbVAaXi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVAaXi6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 18:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbVAaXiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 18:38:46 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:16295 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261437AbVAaXhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 18:37:40 -0500
Subject: Re: Bug: audio playing broke with my SCSI CD and DVD drives in
	2.6.11-rc2-bk7 and beyond.
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
In-Reply-To: <Pine.LNX.4.62.0502010013470.3217@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.62.0502010013470.3217@dragon.hygekrogen.localhost>
Content-Type: multipart/mixed; boundary="=-XgPmIjol1VoorFu985AF"
Date: Mon, 31 Jan 2005 17:37:28 -0600
Message-Id: <1107214648.4532.33.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XgPmIjol1VoorFu985AF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-02-01 at 00:22 +0100, Jesper Juhl wrote:
> audio

Could you try the attached?

James


--=-XgPmIjol1VoorFu985AF
Content-Disposition: inline
Content-Description: Attached message - Re: 2.6.11-rc[1,2]-mmX scsi cdrom
	problem, 2.6.10-mm2 ok
Content-Type: message/rfc822

Return-Path: <linux-scsi-owner@vger.kernel.org>
Received: from localhost.localdomain (orville.steeleye.com [209.192.50.34])
	by hancock.sc.steeleye.com (8.11.6/8.11.6) with ESMTP id j0VDBhb22850; Mon,
	31 Jan 2005 08:11:43 -0500
Received: from vger.kernel.org (vger.kernel.org [12.107.209.244]) by
	localhost.localdomain (8.12.8/8.12.8) with ESMTP id j0VFNea9017140; Mon, 31
	Jan 2005 10:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
	S261189AbVAaNKm (ORCPT <rfc822;Eddie.Williams@steeleye.com> + 1 other);
	Mon, 31 Jan 2005 08:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVAaNKm
	(ORCPT <rfc822;linux-scsi-outgoing>); Mon, 31 Jan 2005 08:10:42 -0500
Received: from borg.st.net.au ([65.23.158.22]:59848 "EHLO borg.st.net.au")
	by vger.kernel.org with ESMTP id S261188AbVAaNJq (ORCPT
	<rfc822;linux-scsi@vger.kernel.org>); Mon, 31 Jan 2005 08:09:46 -0500
Received: from localhost (localhost [127.0.0.1]) by borg.st.net.au
	(Postfix) with ESMTP id 94007394529; Mon, 31 Jan 2005 23:09:41 +1000 (EST)
Received: from [192.168.48.80]
	(dsl-250.128.240.220.lns02-wick-bne.dsl.comindico.com.au [220.240.128.250])
	by borg.st.net.au (Postfix) with ESMTP id 8077339450F; Mon, 31 Jan 2005
	23:09:37 +1000 (EST)
Message-ID: <41FE2DFB.1090801@torque.net>
Date: Mon, 31 Jan 2005 23:09:15 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: Fabio Coatti <cova@ferrara.linux.it>, akpm@osdl.org, lkml <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: Re: 2.6.11-rc[1,2]-mmX scsi cdrom problem, 2.6.10-mm2 ok
References: <200501310034.32005.cova@ferrara.linux.it>
	 <20050131080021.GA9446@suse.de> <200501311108.19593.cova@ferrara.linux.it>
	 <20050131110550.GA5058@suse.de> <41FE1B39.6030702@torque.net>
	 <20050131114943.GD5058@suse.de>
In-Reply-To: <20050131114943.GD5058@suse.de>
Content-Type: multipart/mixed; boundary="------------090707080707000000020307"
X-Scanned-By: AMaViS-ng at borg.st.net.au
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	hancock.sc.steeleye.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00 autolearn=ham 
	version=3.0.2
X-Evolution-Source: imap://jejb@172.17.4.1/

This is a multi-part message in MIME format.
--------------090707080707000000020307
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Jens Axboe wrote:
> On Mon, Jan 31 2005, Douglas Gilbert wrote:
> 
>>Jens Axboe wrote:
>>
>>>On Mon, Jan 31 2005, Fabio Coatti wrote:
>>>
>>>
>>>>Alle 09:00, lunedì 31 gennaio 2005, Jens Axboe ha scritto:
>>>>
>>>>
>>>>>>At this point k3b is stuck in D stat, needs reboot.

I was able to replicate this with a USB burner.
My system didn't need a reboot. The "D" state was locked
on "blk_execute_rq". The burner was still accessible via
sg.

>>>>>The most likely suspect is the REQ_BLOCK_PC scsi changes. Can you try
>>>>>2.6.11-rc2-mm1 with bk-scsi backed out? (attached)
>>>>
>>>>just tried, right guess :)
>>>>backing out that patch the problem disappears.
>>>>Let me know if you need to narrow further that issue.
>>>
>>>
>>>Doug, it looks like your REQ_BLOCK_PC changes are buggy. Let me know if
>>>you cannot find the full post and I'll forward it to you.
>>
>>Jens,
>>Hmm. Found the thread on lkml. I got an almost identical
>>lock up in k3b with a USB external cd/dvd drive recently.
>>My laptop didn't need rebooting (probably since the root
>>fs is one an ide disk).
>>
>>That is a quite large patch that you referenced. I'll
>>try and replicate and report back.
> 
> 
> My guess would be the scsi_lib changes, I would suggest you start there.

Indeed. I'm not sure what I was thinking in
scsi_io_completion(). This small reversion
fixes my k3b problem; tested with a USB external
burner.

Signed-off-by: Douglas Gilbert <dougg@torque.net>





--------------090707080707000000020307
Content-Type: text/x-patch; name="scsi_lib2611rc2bk8.diff"
Content-Disposition: inline; filename="scsi_lib2611rc2bk8.diff"
Content-Transfer-Encoding: 7bit

--- linux/drivers/scsi/scsi_lib.c	2005-01-31 17:46:31.000000000 +1000
+++ linux/drivers/scsi/scsi_lib.c2611r2b8_k3b	2005-01-31 22:46:04.000000000 +1000
@@ -692,6 +692,7 @@
 	int this_count = cmd->bufflen;
 	request_queue_t *q = cmd->device->request_queue;
 	struct request *req = cmd->request;
+	int clear_errors = 1;
 	struct scsi_sense_hdr sshdr;
 	int sense_valid = 0;
 	int sense_deferred = 0;
@@ -721,6 +722,7 @@
 	if (blk_pc_request(req)) { /* SG_IO ioctl from block level */
 		req->errors = result;
 		if (result) {
+			clear_errors = 0;
 			if (sense_valid) {
 				/*
 				 * SG_IO wants current and deferred errors
@@ -745,11 +747,6 @@
 	cmd->request_buffer = NULL;
 	cmd->request_bufflen = 0;
 
-	if (blk_pc_request(req)) { /* SG_IO ioctl from block level */
-		scsi_end_request(cmd, 1, good_bytes, 0);
-		return;
-	}
-
 	/*
 	 * Next deal with any sectors which we were able to correctly
 	 * handle.
@@ -759,7 +756,8 @@
 					      req->nr_sectors, good_bytes));
 		SCSI_LOG_HLCOMPLETE(1, printk("use_sg is %d\n", cmd->use_sg));
 
-		req->errors = 0;
+		if (clear_errors)
+			req->errors = 0;
 		/*
 		 * If multiple sectors are requested in one buffer, then
 		 * they will have been finished off by the first command.

--------------090707080707000000020307--

-
To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=-XgPmIjol1VoorFu985AF--

