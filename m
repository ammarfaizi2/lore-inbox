Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbULZObJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbULZObJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 09:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbULZObJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 09:31:09 -0500
Received: from bay15-f26.bay15.hotmail.com ([65.54.185.26]:56868 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261656AbULZObH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 09:31:07 -0500
Message-ID: <BAY15-F265CCA05303049813A8802B2980@phx.gbl>
X-Originating-IP: [61.10.7.56]
X-Originating-Email: [mbenz74@hotmail.com]
From: "M Benz" <mbenz74@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: is my RAID safe?
Date: Sun, 26 Dec 2004 14:30:36 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=big5; format=flowed
X-OriginalArrivalTime: 26 Dec 2004 14:31:05.0790 (UTC) FILETIME=[887EA5E0:01C4EB57]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today I found this that at my /var/log/message (kernel 2.6.10):

Dec 26 21:35:14 s1 kernel: ata5: status=0x51 { DriveReady SeekComplete 
Error }
Dec 26 21:35:14 s1 kernel: ata5: error=0x84 { DriveStatusError BadCRC }

ata5 is md raid1 with ata6, both are sata drives connected to a promise 
SATA controller.

at /proc/mdstat, the raid 1 is still active with "[UU]"

Is my raid 1 safe and should I replace the "ata5" drive? Also, why the 
raid-1 still up with status "[UU]" ?

Thanks

_________________________________________________________________
使用全球用戶最多的電子郵件服務 MSN Hotmail： http://www.hotmail.com 

