Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287193AbSACMWb>; Thu, 3 Jan 2002 07:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287199AbSACMWW>; Thu, 3 Jan 2002 07:22:22 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62724 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287193AbSACMWD>; Thu, 3 Jan 2002 07:22:03 -0500
Subject: Re: kswapd etc hogging machine
To: akpm@zip.com.au (Andrew Morton)
Date: Thu, 3 Jan 2002 12:32:12 +0000 (GMT)
Cc: znmeb@aracnet.com (M. Edward Borasky), art@lsr.nei.nih.gov (Art Hays),
        linux-kernel@vger.kernel.org
In-Reply-To: <3C33E8EA.FAF8E337@zip.com.au> from "Andrew Morton" at Jan 02, 2002 09:15:22 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16M72b-0008B8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But Art's kernel (what kernel is in RH7.2 anyway?  2.4.9 with vendor
> hacks^Wfixes, I think) is nowhere near that stage.

7.2 is 2.4.7-ac ish, 7.2 + errata is 2.4.9-ac ish

> The good news is that 2.4.17 has pretty much slain this dragon.  The
> -aa patches are better still, and 2.4.18 will be even better than
> that.

Bollocks. I get regular mails from large numbers of people who are stuck
at 2.4.12/13-ac and are hoping I'll do an update because their machines
die in hours or run 25-50% slower with 2.4.1x.

2.4.1x VM code is performing better under light loads but its absolutely
and completely hopeless under a real paging load. 2.4.17-aa is somewhat
better interestingly.

Alan
