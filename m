Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbULIIKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbULIIKw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 03:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbULIIKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 03:10:52 -0500
Received: from bay5-f18.bay5.hotmail.com ([65.54.173.18]:40379 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261491AbULIIKq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 03:10:46 -0500
Message-ID: <BAY5-F186433AE314D0B1687EDC0A4B70@phx.gbl>
X-Originating-IP: [61.220.240.162]
X-Originating-Email: [ejhsu@msn.com]
From: "Hsu I-Chieh" <ejhsu@msn.com>
To: linux-kernel@vger.kernel.org
Subject: Can't call function provided by kernel
Date: Thu, 09 Dec 2004 08:09:08 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=big5; format=flowed
X-OriginalArrivalTime: 09 Dec 2004 08:10:01.0362 (UTC) FILETIME=[7B360F20:01C4DDC6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm writing a kernel module in kernel 2.6.x. I called local_flush_tlb_all() 
in my module 
and there is no error or warning during compiling time. The code fragment 
is as follow:

#include <asm/tlbflush.h>

void tlb_flush()
{
    ....
    local_flush_tlb_all();
    ....
}

But when i insert this module into kernel, the message below is displayed:
    mymodule: Unknown symbol local_flush_tlb_all
    insmod: cannot insert `./mymodule.ko': Success (2): Success

Please do help!!

TIA
 
With regards,

Jacky Hsu

_________________________________________________________________
立即申請 MSN Mobile 服務：用手機和 MSN Messenger 網友隨時交談  
http://msn.com.tw/msnmobile 

