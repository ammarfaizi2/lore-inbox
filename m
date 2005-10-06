Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbVJFFSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbVJFFSZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 01:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbVJFFSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 01:18:25 -0400
Received: from mx1.cdacindia.com ([203.199.132.35]:48536 "HELO
	mailx.cdac.ernet.in") by vger.kernel.org with SMTP id S1750733AbVJFFSY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 01:18:24 -0400
Message-ID: <4344AA81.2020304@cdac.in>
Date: Thu, 06 Oct 2005 10:09:29 +0530
From: Karthik Sarangan <karthiks@cdac.in>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Using DMA in read/write, setting block size for I/O ->	max_sectors
References: <434288E9.3090108@cdac.in>	 <1128436401.2922.11.camel@laptopd505.fenrus.org> <43437163.1020201@cdac.in>	 <1128500135.2920.11.camel@laptopd505.fenrus.org> <4343A046.1090605@cdac.in> <1128507966.2920.13.camel@laptopd505.fenrus.org>
In-Reply-To: <1128507966.2920.13.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

> no it's a property of the hardware and as such the DRIVER has to set it.
> Not all hw can deal with really big sizes, so the driver is supposed to
> set what the hw is capable of.
> 
so I need to send some ioctl to the driver to set the transfer size or 
find something in the /proc/scsi area, isn't it?
