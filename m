Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbUCaVC6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 16:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbUCaVC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 16:02:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32715 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262490AbUCaVC4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 16:02:56 -0500
Message-ID: <406B31F3.1010702@pobox.com>
Date: Wed, 31 Mar 2004 16:02:43 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-ide@vger.kernel.org
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [sata] libata update
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Small update, to fix a couple important 2.4-only bugs:
* SMP kernels would lock up during probing
* Hardware delays were incorrect, due to HZ=100

2.6.x kernels are not affected.

Also included is a fix for sata_via device-1 detection, which does 
affect 2.6.x kernels.


BK repositories:
	http://gkernel.bkbits.net/libata-2.[46]

2.4.x patch and log:
ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.4.26-rc1-libata3.patch.bz2
ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.4.26-rc1-libata3.log

2.6.x patch and log:
ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.5-rc3-libata2.patch.bz2
ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.5-rc3-libata2.log



