Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266137AbUFUHTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266137AbUFUHTI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 03:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266138AbUFUHTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 03:19:08 -0400
Received: from 10.69-93-172.reverse.theplanet.com ([69.93.172.10]:46232 "EHLO
	gsf.ironcreek.net") by vger.kernel.org with ESMTP id S266137AbUFUHRd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 03:17:33 -0400
From: Andre Eisenbach <andre@eisenbach.com>
To: linux-kernel@vger.kernel.org
Subject: [2.6.7-mm1] Firewire sbp2 problem
Date: Mon, 21 Jun 2004 01:25:23 -0700
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406210125.23577.andre@eisenbach.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey there! 
 
 I have a firewire hard drive which I have previously used with an earlier 
kernel. However, after a recent OS reinstall, I cannot access the drive 
anymore. 
 
 Here is the related dmsg output: 
 
ieee1394: raw1394: /dev/raw1394 device initialized 
 ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000bcd009e53243d] 
 ieee1394: Error parsing configrom for node 0-01:1023 
 ieee1394: The root node is not cycle master capable; selecting a new root 
node and resetting... 
 ieee1394: Error parsing configrom for node 0-00:1023 
 ieee1394: Node changed: 0-00:1023 -> 0-01:1023 
 sbp2: $Rev: 1219 $ Ben Collins <bcollins@debian.org>

 Note that there is no further report from sbp2. Nothing happens. 
 
 I'm using kernel 2.6.7-mm1. 
 
 IEEE1394 related config options: 

# IEEE 1394 (FireWire) support 
 CONFIG_IEEE1394=y 
 # CONFIG_IEEE1394_VERBOSEDEBUG is not set 
 CONFIG_IEEE1394_OUI_DB=y 
 # CONFIG_IEEE1394_EXTRA_CONFIG_ROMS is not set 
 CONFIG_IEEE1394_PCILYNX=y 
 CONFIG_IEEE1394_OHCI1394=y 
 CONFIG_IEEE1394_VIDEO1394=y 
 CONFIG_IEEE1394_SBP2=m 
 # CONFIG_IEEE1394_SBP2_PHYS_DMA is not set 
 # CONFIG_IEEE1394_ETH1394 is not set 
 CONFIG_IEEE1394_DV1394=y 
 CONFIG_IEEE1394_RAWIO=y 
 # CONFIG_IEEE1394_CMP is not set

 
 SCSI related: 
 
CONFIG_BLK_DEV_IDESCSI=y 
 CONFIG_SCSI=y 
 CONFIG_SCSI_PROC_FS=y 
 CONFIG_BLK_DEV_SD=y

 
 Dont know what to do anymore  
 The firewire hard drive contains the backup of my previous gentoo 
installation. I *need* that data . 
 
 Thanks for your help...
