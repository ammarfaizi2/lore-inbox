Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbVLCCnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbVLCCnX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 21:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbVLCCnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 21:43:23 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:28557 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750858AbVLCCnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 21:43:22 -0500
Date: Fri, 02 Dec 2005 20:43:15 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: SMART over USB - problem
In-reply-to: <5fuei-2bW-3@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43910643.7080706@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <5fuei-2bW-3@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

art wrote:
> works on SCSI/IDE why not on IDE over USB/IEEE1394/iSCSI/SAN... ???
> 
> is the problem in my external usb box or in linux usb/scsi stack ???

The USB interface chip in the enclosure implements a purely USB mass 
storage interface. The system knows nothing about whether the hard drive 
in the enclosure is IDE, SCSI or whatever. I don't think there is any 
standardized way to get SMART data out of a USB storage device.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

