Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbTIKQLN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 12:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbTIKQLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 12:11:12 -0400
Received: from zeus.netlab.rm.cnr.it ([150.146.100.23]:46018 "EHLO
	zeus.netlab.rm.cnr.it") by vger.kernel.org with ESMTP
	id S261351AbTIKQLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 12:11:09 -0400
Message-ID: <3F60A0B9.6010001@iname.com>
Date: Thu, 11 Sep 2003 18:20:09 +0200
From: Flavio <flavio26@iname.com>
Reply-To: flavio26@iname.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM:SCSI repeatable 2.4.22 bug
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for sending previous email unfinished,
my finger was quicker than my mind...

I am trying to switch off dma on DVD-ROM which is used by ide-scsi,
hdparm is useless, should I try to hdparm it before ide-scsi driver 
loads or use some command under scsi?

TIA,

Flavio


> On Mer, 2003-09-10 at 13:39, flavio wrote:
>> Hi,
>>
>> the hd and dvd light are constantly on from boot onwards (using vanilla
>> 2.4.22 and the /var/log/messages is a sequence of messages as in
>> attachment).
>> 2.4.20 vanilla has no problems whatsoever...
> 
> Your drive is returning more data than it was asked for or expected.
> What model drives do you have and does turning off DMA for non disk fix
> it ?

I have a fujitsu laptop with:

IC25N030ATCS04-0 ibm 30gb ide drive

ide dvd/cdrw drive using ide-scsi driver:

cat /proc/scsi/scsi:
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
     Vendor: TOSHIBA  Model: DVD-ROM SD-R2212 Rev: 1F15
     Type:   CD-ROM                           ANSI SCSI revision: 02

hdparm is not present on disk, so I suppose hd parameters are not
changed by rc scripts...




