Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932768AbVJ3AGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932768AbVJ3AGH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 20:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932769AbVJ3AGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 20:06:07 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:37583 "EHLO
	pd2mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932768AbVJ3AGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 20:06:05 -0400
Date: Sat, 29 Oct 2005 18:05:52 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: LSI LOGIC I/O Error on 2.6.12.6
In-reply-to: <51NTC-5i3-5@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43640E60.8040705@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <51NTC-5i3-5@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

govind wrote:
> Hi,
> 
> We are trying to make use of a LSI LOGICS SAS drives in a customized
> Linux distribution of 2.6.12.6 kernel version. We are hitting upon an
> I/O Error on trying to access the drives. Have anybody faced this
> problem?
> 
> The following are the details:
> sdb: Current: sense key=0x3
>     ASC=0x11 ASCQ=0x0
> end_request: I/O error, dev sdb, sector 0
> Buffer I/O error on device sdb, logical block 0
> SCSI error : <1 0 8 0> return code = 0x8000002
> sdb: Current: sense key=0x3
>     ASC=0x11 ASCQ=0x0
> end_request: I/O error, dev sdb, sector 0
> Buffer I/O error on device sdb, logical block 0
>  unable to read partition table

Sense 0x3, ASC 0x11, ASCQ 0x00 seems to be "Unrecovered Read Error". Are 
you sure that drive for sdb is not faulty?

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

