Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262873AbVCWURD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbVCWURD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 15:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262891AbVCWURD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 15:17:03 -0500
Received: from grunt1.ihug.co.nz ([203.109.254.41]:43672 "EHLO
	grunt1.ihug.co.nz") by vger.kernel.org with ESMTP id S262873AbVCWUP3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 15:15:29 -0500
Date: Thu, 24 Mar 2005 08:15:26 +1200 (NZST)
From: steve@perfectpc.co.nz
X-X-Sender: sk@steve.kieu
Reply-To: steve@perfectpc.co.nz
To: linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Fw: Problem report. USB MP3 Player no longer
 work with kernel > 2.6.8 (fwd)
Message-ID: <Pine.LNX.4.62.0503240814440.1697@steve.kieu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just correct one of the typo I made

Hi, Just test 2.6.12-rc1 and it works now. I tested it cz I saw lots of 
changes 
in usb=storage in the log not sure which item is applied. Do you still need the 
info. with 2.6.11? When working the type of disck is like:

with 2.6.12-rc1

usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
   Vendor: SigmaTel  Model: MSCN              Rev: 0100
   Type:   Direct-Access                      ANSI SCSI revision: 04
usb-storage: device scan complete
SCSI device sda: 501760 512-byte hdwr sectors (257 MB)
sda: assuming Write Enabled
sda: assuming drive cache: write through
SCSI device sda: 501760 512-byte hdwr sectors (257 MB)
sda: assuming Write Enabled
sda: assuming drive cache: write through
  sda: sda1
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0

The Vendor and Type etc.. are the same if using 2.6.8. With 2.6.9, 10, and 11 
it did not detect device.

Let me know if you still interested to debug it in 2.6.11 (I think no need :-) 
)

Thank you

Cheers,

