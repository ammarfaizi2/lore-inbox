Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbUFESBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbUFESBq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 14:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbUFESBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 14:01:45 -0400
Received: from cyberhostplus.biz ([209.124.87.2]:51178 "EHLO
	server.cyberhostplus.biz") by vger.kernel.org with ESMTP
	id S261832AbUFESBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 14:01:43 -0400
From: "Steve Lee" <steve@tuxsoft.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Who has record no. of  DriveReady SeekComplete DataRequest errors?
Date: Sat, 5 Jun 2004 13:01:29 -0500
Message-ID: <000401c44b27$24ba1880$8119fea9@pluto>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.cyberhostplus.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - tuxsoft.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Well since 2.6.3 I think I've been getting the record number of 
>
>hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
>hdd: status error: error=0x00
>hdd: drive not ready for command
>hdd: ATAPI reset complete
>
>errors from my cdrw on hdd; and it's only one drive's worth.


I've been witnessing almost exactly the same thing as you.  I assumed,
perhaps falsely, that my AOpen CDRW was failing.  I just recently
replaced it with a DVD-Rom drive and thus far have not seen these
errors.

hdd: status error: status=0x59 { DriveReady SeekComplete DataRequest
Error }
hdd: status error: error=0x20LastFailedSense 0x02
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: DMA disabled
hdd: drive not ready for command
hdd: ATAPI reset complete

Could this be a kernel bug?  Please CC me as I'm no longer subscribed to
this list.

Thanks,
Steve


