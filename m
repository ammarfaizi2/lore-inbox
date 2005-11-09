Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932677AbVKIR55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932677AbVKIR55 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 12:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932682AbVKIR55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 12:57:57 -0500
Received: from bay108-dav9.bay108.hotmail.com ([65.54.162.81]:21130 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S932677AbVKIR5y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 12:57:54 -0500
Message-ID: <BAY108-DAV96479E4CE0434E15A5ABE93670@phx.gbl>
X-Originating-IP: [143.182.124.2]
X-Originating-Email: [multisyncfe991@hotmail.com]
From: "John Smith" <multisyncfe991@hotmail.com>
To: <linux-kernel@vger.kernel.org>
References: <BAY108-DAV14071EF16A4482FB4B691593D10@phx.gbl> <20050714051653.GP8907@alpha.home.local> <BAY108-DAV7F3CC1BA8D84C5323469193D10@phx.gbl> <1121358399.4685.9.camel@localhost>
Subject: Does Printk() block another CPU in dual cpu platforms?
Date: Wed, 9 Nov 2005 10:57:54 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-OriginalArrivalTime: 09 Nov 2005 17:57:54.0666 (UTC) FILETIME=[1C1F5CA0:01C5E557]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I just have a question about the usage of printk in multi-processor 
platforms. If the program on two CPUs both try to call printk to output 
something, will the program running on one CPUs get blocked (or just 
spinning there) till the other is done with printk()?

Thanks,

Liang
