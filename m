Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbVE0DBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbVE0DBD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 23:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbVE0DBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 23:01:03 -0400
Received: from mail.dvmed.net ([216.237.124.58]:35036 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261779AbVE0DAi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 23:00:38 -0400
Message-ID: <42968D4E.10109@pobox.com>
Date: Thu, 26 May 2005 23:00:30 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [work] libata project: START STOP UNIT translation
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If anybody is looking for SATA kernel hacking project, here's a small 
and self-contained one:

	Implement the translation of SCSI command START STOP UNIT in
	drivers/scsi/libata-scsi.c.

Among other things, this will give people with SATA power management 
capabilities.

START STOP UNIT is described at
	http://www.t10.org/ftp/t10/drafts/sbc2/sbc2r16.pdf

The translation of START STOP UNIT from SCSI to ATA is described at
	http://www.t10.org/ftp/t10/drafts/sat/sat-r04.pdf

The relevant ATA commands you will be using are documented at
	http://www.t13.org/docs2004/d1532v1r4b-ATA-ATAPI-7.pdf

More info on SATA hacking can be had by reading
	http://linux.yyz.us/sata/devel.html

or by reading drivers/scsi/libata*.[ch], include/linux/libata.h, 
include/linux/ata.h, and drivers/scsi/sata_*.c.


