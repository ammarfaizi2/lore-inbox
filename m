Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267605AbUHEIkC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267605AbUHEIkC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 04:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267603AbUHEIkC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 04:40:02 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:59915 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S267605AbUHEIhg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 04:37:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Chris Shoemaker <c.shoemaker@cox.net>,
       Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Possible dcache BUG
Date: Thu, 5 Aug 2004 11:35:58 +0300
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408050031.21366.gene.heskett@verizon.net> <20040805004402.GA6304@cox.net>
In-Reply-To: <20040805004402.GA6304@cox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200408051135.58125.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	FWIW, I've seen no fewer than 4 independent reports that looked
> suspiciously like yours and mine over the past 3 months.  Maybe we all
> have bad hardware, and memtest86 just isn't stressful enough to show it.
> The alternative is that there's some bug that has affected several
> versions of 2.6 (and maybe 2.4) that seems to hit in low memory
> conditions (e.g. as a result of a 4am cron.daily, or a large rsync).
>
> 	If you're curious, search google groups for "+oops +prune_dcache
> group:linux.kernel", sort by date and look through the first 3 or 4
> pages.  You'll see the same story with the same oopses over and over.
> I know the few single bit flips are _probably_ bad hardware, but the more
> similarities I see, the more I wonder.
>
> 	But, since my problems have completely gone away by adding more RAM,
> I haven't been motivated to track it down anymore.

Let's rule out PREEMPT first

> 	Sorry I can't be more helpful.  Good luck.

Maybe turn PREEMPT back on?
-- 
vda
