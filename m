Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263150AbVCJVZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263150AbVCJVZL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 16:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263148AbVCJVZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 16:25:10 -0500
Received: from fire.osdl.org ([65.172.181.4]:19656 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263150AbVCJVVP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 16:21:15 -0500
Date: Thu, 10 Mar 2005 13:21:14 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Steven Cole <elenstev@mesatop.com>
Cc: linux-kernel@vger.kernel.org, Russell King <rmk+serial@arm.linux.org.uk>
Subject: Re: Problem with PPPD on dialup with 2.6.11-bk1 and later; 2.6.11
 is OK
Message-ID: <20050310132114.5eda19d7@dxpl.pdx.osdl.net>
In-Reply-To: <200503091914.24612.elenstev@mesatop.com>
References: <200503091914.24612.elenstev@mesatop.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed-Claws 1.0.1 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Stephen Hemminger also wrote: (Someting's busted with serial in 2.6.11 latest)
> >Some checkin since 2.6.11 has caused the serial driver to
> >drop characters.  Console output is chopped and messages are garbled.
> >Even the shell prompt gets truncated.

> Searching lkml archive, I found:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111031501416334&w=2
> 
> I also found that reverting that patch made the problem go away for 2.6.11-bk1.


Yes, this patch is the problem. A fix showed up today.
Current kernels work fine, thanks.
