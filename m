Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965092AbVJEKSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965092AbVJEKSu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 06:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965100AbVJEKSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 06:18:50 -0400
Received: from mx1.cdacindia.com ([203.199.132.35]:32743 "HELO
	mailx.cdac.ernet.in") by vger.kernel.org with SMTP id S965092AbVJEKSu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 06:18:50 -0400
Message-ID: <4343A046.1090605@cdac.in>
Date: Wed, 05 Oct 2005 15:13:34 +0530
From: Karthik Sarangan <karthiks@cdac.in>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Using DMA in read/write, setting block size for I/O -> max_sectors
References: <434288E9.3090108@cdac.in>	 <1128436401.2922.11.camel@laptopd505.fenrus.org> <43437163.1020201@cdac.in> <1128500135.2920.11.camel@laptopd505.fenrus.org>
In-Reply-To: <1128500135.2920.11.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>max_sectors in the host template for scsi

Can I set this parameter during startup for scsi_mod.ko during load?
I actually needed a 256KB transfer size only for my second scsi disk @
/dev/sdb.

Is there some similar load time parameter for the sd_mod.ko module? How
to set it?

