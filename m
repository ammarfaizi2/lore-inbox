Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264072AbUESGvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264072AbUESGvr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 02:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264073AbUESGvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 02:51:47 -0400
Received: from mail.ccdaust.com.au ([203.29.88.42]:4141 "EHLO
	gateway.ccdaust.com.au") by vger.kernel.org with ESMTP
	id S264072AbUESGvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 02:51:45 -0400
Message-ID: <40AB03FF.4070804@wasp.net.au>
Date: Wed, 19 May 2004 10:51:43 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: libata 2.6.5->2.6.6 regression -part II
References: <40A8E9A8.3080100@wasp.net.au> <200405181513.12920.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200405181513.12920.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Monday 17 of May 2004 18:34, Brad Campbell wrote:
>>Is there any way I can prevent the VIA ATA driver capturing this device?
>>Unfortunately my boot drive is on hda on the on-board VIA ATA interface so
>>I need it compiled in.
> 
> 
> Disable the fscking PCI IDE generic driver.
> [ You are not the first one tricked by it. ]
> 
> AFAIR support for VIA 8237 was added to it before sata_via.c was ready.
> [ but my memory is... ]

[Absolutley perfect!]
That did the trick nicely, thanks for the prompt response.

Regards,
Brad

