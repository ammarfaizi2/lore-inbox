Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbTKMTGz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 14:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264391AbTKMTGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 14:06:55 -0500
Received: from ext-nj2gw-3.online-age.net ([216.35.73.165]:23952 "EHLO
	ext-nj2gw-3.online-age.net") by vger.kernel.org with ESMTP
	id S264386AbTKMTGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 14:06:53 -0500
From: "Kiniger, Karl (MED)" <karl.kiniger@med.ge.com>
To: linux-kernel@vger.kernel.org
Date: Thu, 13 Nov 2003 20:06:41 +0100
Subject: how to get inquiry information for /dev/sd? (kernel 2.4.22) 
Message-ID: <20031113190641.GA32661@ki_pc2.kretz.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

using kernel 2.4.22:

what is the canonical method to get to know what
scsi/usb/ieee1394 disks are being accessed as /dev/sda, /dev/sdb etc ?
(e.g want to be sure to format the USB pen drive and not the
M/O disk) 

Right now I am playing with SCSI_IOCTL_GET_IDLUN ioctl but I also need
to get at the inquiry information for each disk device, preferably
w/o having to parse /proc/scsi/scsi. 

Thanks for any hints,
Karl 
-- 
Karl Kiniger        karl.kiniger@med.ge.com
GE Medical Kretztechnik
Tiefenbach 15
A-4871 Zipf         Tel: (++43) 7682-3800-710  Fax (++43) 7682-3800-47
