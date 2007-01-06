Return-Path: <linux-kernel-owner+w=401wt.eu-S1751323AbXAFJGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbXAFJGr (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 04:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbXAFJGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 04:06:46 -0500
Received: from wasp.net.au ([203.190.192.17]:43728 "EHLO wasp.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751207AbXAFJGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 04:06:45 -0500
Message-ID: <459F668A.7050000@wasp.net.au>
Date: Sat, 06 Jan 2007 13:06:18 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Thunderbird 1.5.0.8 (X11/20061117)
MIME-Version: 1.0
To: Brad Campbell <brad@wasp.net.au>
CC: Alan <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       linux-ide@vger.kernel.org,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: problem with pata_hpt37x ...
References: <20070102070144.GA11270@MAIL.13thfloor.at> <20070102145855.170c03e2@localhost.localdomain> <459D26D4.3010601@wasp.net.au> <20070104173058.GA2160@MAIL.13thfloor.at> <459D42B1.20604@wasp.net.au>
In-Reply-To: <459D42B1.20604@wasp.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Campbell wrote:
> Herbert Poetzl wrote:
> 
>> sounds great! where can I get that version?
>> should it be in 2.6.20-rc* or is there a separate
>> patch available somewhere?
> 
> The patch was contained in the message from Alan to you that I replied 
> to. I just applied it to a vanilla 2.6.20-rc3 tree and fired it up.
> 

Just a warning. I'm seeing data corruption on this system. I need to try and narrow it down, but on 
transferring 100 files totalling about 80GB from a USB drive to the drives on this controller I'm 
seeing repeatable and apparently random corruption on the data reaching the disks. I don't recall 
seeing this when I used SIL controllers in place of the HPT but I now have an easily repeatable test 
case so I'll keep testing until I peg it.


Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
