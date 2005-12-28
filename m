Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbVL1Hdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbVL1Hdu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 02:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbVL1Hdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 02:33:50 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:54011 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932491AbVL1Hdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 02:33:50 -0500
Date: Wed, 28 Dec 2005 01:33:45 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Serial ATA Lockups
In-reply-to: <5oCZ7-3FB-17@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43B23FD9.2060004@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <5oCZ7-3FB-17@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Carnecky wrote:
> My setup: Shuttle XPC Barebone, AMD CPU, two serial ATA disks in a 
> software raid setup.
> When the system is under heavy load (start World of Warcraft, dd 
> if=/dev/zero of=/part/file etc) I get these messages in dmesg:
> 
> ata1: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
> ata1: status=0x51 { DriveReady SeekComplete Error }
> ata1: error=0x84 { DriveStatusError BadCRC }
> 
> over and over, pages with these messages.

BadCRC indicates CRC errors during data transfers on the SATA interface. 
This is almost certainly hardware problems - most likely a bad SATA 
cable, or maybe a bad drive or motherboard controller.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

