Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264855AbUEQBM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264855AbUEQBM7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 21:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264878AbUEQBM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 21:12:59 -0400
Received: from web50003.mail.yahoo.com ([206.190.38.18]:11634 "HELO
	web50003.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264855AbUEQBM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 21:12:58 -0400
Message-ID: <20040517011257.86012.qmail@web50003.mail.yahoo.com>
Date: Sun, 16 May 2004 18:12:57 -0700 (PDT)
From: fc scsi <scsi_fc_group@yahoo.com>
Subject: _PAGE_PCD bit in DMAable memory
To: linux-kernel@vger.kernel.org
Cc: scsi_fc_group@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 
I am trying to get DMAable memory on i386
(kmalloc(GFP_DMA,)) but seems 
_PAGE_PCD is not set on the pages that i get back the
memory from. Am I 
getting the correct results? If yes, then is it not
that GFP_DMA should 
give me non-cacheable memory (equivalent to setting
_PAGE_PCD along 
with _PAGE_PWT on i386). Can anyone confirm for me
that GFP_DMA will 
*always* give me non-cacheable and contiguous memory.
 
Many thanks in advance.




	
		
__________________________________
Do you Yahoo!?
SBC Yahoo! - Internet access at a great low price.
http://promo.yahoo.com/sbc/
