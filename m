Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbTIMATd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 20:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbTIMATd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 20:19:33 -0400
Received: from mrout3.yahoo.com ([216.145.54.173]:37642 "EHLO mrout3.yahoo.com")
	by vger.kernel.org with ESMTP id S261960AbTIMATb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 20:19:31 -0400
Message-ID: <3F62628B.5060805@bigfoot.com>
Date: Fri, 12 Sep 2003 17:19:23 -0700
From: Erik Steffl <steffl@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i386; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: intel D865PERL and DMA for disks (IDE)?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   I am trying to set the DMA for ide disks but get the following error:

   jojda:/home/erik# hdparm -d 1 /dev/hda

/dev/hda:
  setting using_dma to 1 (on)
  HDIO_SET_DMA failed: Operation not permitted
  using_dma    =  0 (off)

   is it because it's not supported on given chipset or is there 
something I can do?

   debian unstable
   2.4.21-ac4 (+ libata5 patches from Jeff Garzik)
   Intel D865PERL motherboard

   there are only two kernel options that I can see are relevant to 
chipset I use:

CONFIG_BLK_DEV_PIIX=m
CONFIG_SCSI_ATA_PIIX=y

   TIA

	erik


