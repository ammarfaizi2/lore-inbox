Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265462AbUF2FfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265462AbUF2FfF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 01:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265467AbUF2FfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 01:35:05 -0400
Received: from web90101.mail.scd.yahoo.com ([66.218.94.72]:45962 "HELO
	web90101.mail.scd.yahoo.com") by vger.kernel.org with SMTP
	id S265462AbUF2FfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 01:35:00 -0400
Message-ID: <20040629053458.38834.qmail@web90101.mail.scd.yahoo.com>
Date: Mon, 28 Jun 2004 22:34:58 -0700 (PDT)
From: Kernel The <erforschen_linux@yahoo.com>
Subject: RAW I/O
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have written a RAM disk driver and I want to write
the data to a backup disk/partition while unloading
the driver.

I want to do RAW I/O to a disk/partition from my ram
disk driver. How I can achieve this?

alloc_kiovec(..), map_user_kiobuf(...) and
brw_kiovec(...) functions can be used for this? But
these function map user space into kernel space
memory, but in my driver I will be having only kernel
space memory.

Thanks in advance!
Erforschen


		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - Send 10MB messages!
http://promotions.yahoo.com/new_mail 
