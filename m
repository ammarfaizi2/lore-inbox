Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268728AbUIXMy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268728AbUIXMy5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 08:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268726AbUIXMy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 08:54:57 -0400
Received: from stgeorges-1-81-56-1-93.fbx.proxad.net ([81.56.1.93]:38574 "EHLO
	garfield") by vger.kernel.org with ESMTP id S268728AbUIXMx6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 08:53:58 -0400
Message-ID: <415418DC.1090601@free.fr>
Date: Fri, 24 Sep 2004 14:53:48 +0200
From: Fabian Fenaut <fabian.fenaut@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 MultiZilla/1.6.4.0b
X-Accept-Language: French/France, fr-FR, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Libata - sata_sil - error
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was writing to my sata drive, and I've just had this :

Sep 24 14:26:58 odie kernel: scsi1: ERROR on channel 0, id 0, lun 0, 
CDB: Read (10) 00 03 14 ca a7 00 00 08 00
Sep 24 14:26:58 odie kernel: Current sda: sense key Medium Error
Sep 24 14:26:58 odie kernel: Additional sense: Unrecovered read error - 
auto reallocate failed
Sep 24 14:26:58 odie kernel: end_request: I/O error, dev sda, sector 
51694247
Sep 24 14:26:58 odie kernel: ATA: abnormal status 0x58 on port 0xE080E087
Sep 24 14:26:58 odie last message repeated 2 times

uname -r = 2.6.7-mm7-ff

Drive : Vendor: ATA       Model: ST3120026AS       Rev: 3.05

Full dmesg : http://fabian.fenaut.free.fr/linux/dmesg-2.6.7-mm7-ff
.config : http://fabian.fenaut.free.fr/linux/config-2.6.7-mm7-ff

Since 7 sept, I had "EXT3-fs warning: mounting fs with errors, running
e2fsck is recommended" when mounting this drive. So I tried to fsck, but
it hangs and nothing happened.

Please help :)

Fabian
