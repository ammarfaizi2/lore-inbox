Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262486AbTEFJUl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 05:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbTEFJUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 05:20:41 -0400
Received: from msr67.hinet.net ([168.95.4.167]:33187 "EHLO msr67.hinet.net")
	by vger.kernel.org with ESMTP id S262486AbTEFJUk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 05:20:40 -0400
Date: Tue, 06 May 2003 17:33:14 +0800
From: Tommy Wu <tommy@teatime.com.tw>
To: linux-kernel@vger.kernel.org
Subject: 2.5.69, aar_rx_intr, irq 30: nobody cared! 
Reply-To: tommy@teatime.com.tw
Organization: TeaTime Development
Message-Id: <20030506173007.FDEC.TOMMY@teatime.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.05.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

May  6 13:15:37 test kernel: handlers:
May  6 13:15:37 test kernel: [aac_rx_intr+0/212]
May  6 13:15:37 test kernel: irq 30: nobody cared!
May  6 13:15:37 test kernel: Call Trace: [handle_IRQ_event+147/232]  [do_IRQ+194/304]
  [  common_interrupt+24/32]  [try_to_unmap_one+275/368]  [bio_put+24/48]  
  [end_bio_bh_io_sync+33/48]  [bio_endio+70/76]  [__end_that_request_first+256/464] 
  [end_that_request_first+23/28]  [scsi_end_request+36/160]  [scsi_io_completion+561/1100]
  [sd_rw_intr+470/480]  [scsi_finish_command+208/216]  [scsi_softirq+490/516]  
  [do_softirq+106/200]  [do_IRQ+288/304]  [default_idle+0/52]  [rest_init+0/72]  
  [common_interrupt+24/32]  [default_idle+0/52]  [rest_init+0/72]  [default_idle+41/52]  
  [cpu_idle+55/72]  [rest_init+69/72]  [start_kernel+379/384]

-- 


