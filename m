Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271530AbTGQVAm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 17:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271531AbTGQVAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 17:00:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20390 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S271058AbTGQVAG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 17:00:06 -0400
Message-ID: <3F1711C8.6040207@pobox.com>
Date: Thu, 17 Jul 2003 17:14:48 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
CC: Vojtech Pavlik <vojtech@suse.cz>
Subject: libata driver update posted
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just updated libata library and associated ata_piix driver with several 
bug fixes and internal improvements.  It now works in 2.6 (again).

Next update will add several host drivers, now that the libata API is 
settling down.


2.4.21-based patch:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.4/2.4.21-libata4.patch.bz2

2.4.21-based BitKeeper repo:
bk://kernel.bkbits.net/jgarzik/atascsi-2.4

2.6.0-test1-based patch:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-test1-libata1.patch.bz2

2.6.0-test1-based BitKeeper repo:
bk://kernel.bkbits.net/jgarzik/atascsi-2.5
(yes, "2.5" is not a typo, I haven't changed the name to 2.6 yet)


Remove the ".??" if the file has not appeared on your favorite 
kernel.org mirror yet.


Changes:
* beginnings of pluggable timing configuration
* beginnings of cable detection
* much improved ATA device probing
* a bunch of internal improvements and cleanups (too many to list)
* additional of DocBook documentation
* many bug fixes

