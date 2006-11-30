Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030682AbWK3QRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030682AbWK3QRW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 11:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967836AbWK3QRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 11:17:22 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:47851 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S967837AbWK3QRV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 11:17:21 -0500
Message-ID: <456F0432.8010203@cfl.rr.com>
Date: Thu, 30 Nov 2006 11:17:54 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Jun Sun <jsun@junsun.net>, linux-kernel@vger.kernel.org
Subject: Re: failed 'ljmp' in linear addressing mode
References: <20061122234111.GA8499@srv.junsun.net> <Pine.LNX.4.61.0611270843500.4092@chaos.analogic.com> <20061127231646.GA21627@srv.junsun.net> <Pine.LNX.4.61.0611280806280.7116@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0611280806280.7116@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Nov 2006 16:18:16.0082 (UTC) FILETIME=[240F5720:01C7149B]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14844.003
X-TM-AS-Result: No--7.276500-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> Get a copy of the Intel 486 Microprocessor Reference Manual or read it on-
> line. There is no way that you can make a call like that. You would need to
> call through a task-gate or otherwise set the code-segment and the instruction 
> pointer at the same instant. First, look at the startup code for a GDT entry 

Setting the code segment and instruction pointer at the same time is 
exactly what the long jump does.

OP:  What is at the linear address 0x10000000?


