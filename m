Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbTJEXPi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 19:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263890AbTJEXPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 19:15:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16318 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263886AbTJEXPg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 19:15:36 -0400
Message-ID: <3F80A60B.30306@pobox.com>
Date: Sun, 05 Oct 2003 19:15:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
CC: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: libata update posted
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New version of my Serial ATA (SATA) driver posted.  Main change is 
better integration with the drivers/ide driver.

Current libata SATA hardware support status:
* Intel ICH5:			production
* ServerWorks / Apply K2:	production
* Silicon Image:		developers only.  known to lock up.
* VIA:				beta.  1 failure on 64-bit.

Patch for 2.4 (diff'd against latest 2.4.23-pre BK snapshot):
ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.4.22-bk28-libata1.patch.bz2

Patch for 2.6.0-test (diff'd against latest 2.6.0-test6 BK snapshot):
ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.0-test6-bk7-libata1.patch.bz2

BK repositories:
	http://gkernel.bkbits.net/libata-2.[45]
		or
	bk://kernel.bkbits.net/jgarzik/libata-2.[45]

Coming soon:
* Promise SATA support.
* Silicon Image fix (needs to ack some more interrupts)
* Hardware queueing (TCQ) support for Promise, ServerWorks

I wonder if there is a "linux-ide" mailing list somewhere......

	Jeff




