Return-Path: <linux-kernel-owner+willy=40w.ods.org-S382223AbUKBIDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S382223AbUKBIDR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 03:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S450407AbUKBIDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 03:03:17 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:7591 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S382223AbUKBIDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 03:03:08 -0500
Message-ID: <41873F38.7030609@yahoo.com.au>
Date: Tue, 02 Nov 2004 19:03:04 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Brad Campbell <brad@wasp.net.au>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-rc1-bk page allocation failure. order:2, mode:0x20
References: <41873452.8040804@wasp.net.au>
In-Reply-To: <41873452.8040804@wasp.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Campbell wrote:
> G'day all,
> 
> I'm still getting quite a lot of these come up in the logs when the 
> system is under mild load.
> I suspect it might have something to do with running an MTU of 9000 on 
> the main ethernet port which is directly feeding a workstation with an 
> NFS root (and thus gets quite a high load at times)
> 
> It's not so much an issue but it does cause the workstation to stall for 
> up to a second while it waits for data every time it occurs.
> 
> The loaded ethernet port is this one on an PCI card
> 
> 0000:00:0d.0 Ethernet controller: Marvell Technology Group Ltd. Yukon 
> Gigabit Ethernet 10/100/1000Base-T Adapter (rev 12)
> 
> This started rearing its ugly head when I moved from 2.6.5 to 2.6.9-preX 
> and persists with BK as of about 2 days ago.
> 

There are patches in the newest -mm kernels that should help the
problem. If you're willing to test them, the feedback would be
welcome.

Thanks
Nick
