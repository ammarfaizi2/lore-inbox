Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbWIDMCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbWIDMCt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 08:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbWIDMCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 08:02:49 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:64185 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S964841AbWIDMCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 08:02:48 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: PATA drivers queued for 2.6.19
Date: Mon, 04 Sep 2006 22:02:33 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <po4of2pnhpc0325kqj2hd37b7eh3epcdsm@4ax.com>
References: <44FC0779.9030405@garzik.org>
In-Reply-To: <44FC0779.9030405@garzik.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Sep 2006 07:01:13 -0400, Jeff Garzik <jeff@garzik.org> wrote:

>
>I just pulled the "pata-drivers" branch of libata-dev.git into the 
>"upstream" branch, which means that Alan's libata PATA driver collection 
>is now queued for 2.6.19.
>
>Testing-wise, these PATA drivers have been Andrew Morton's -mm tree for 
>many months.  Community-wise, no one posted objections to the PATA 
>driver merge plan, when Alan posted it on LKML and linux-ide.

Too friggin' hard to test Alan's stuff for older IDE here, therefore 
ignored so far :(   I have some old hardware that Alan is addressing, 
even an old IBM 260MB PCMCIA HDD.

I can't see an easy way to arrange multi-boot with different /etc/fstab 
depending if I'm trying /dev/hdaX or /dev/sdaX.  Parallel '/' partitions?


Plus, 2.6.18-rcX fails too early in boot on one machine (p100 IBM 365X) 
for any testing.  Suggestions welcome...

Grant.

-- 
VGER BF report: U 0.488991
