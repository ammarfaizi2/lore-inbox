Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWJBDyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWJBDyz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 23:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWJBDyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 23:54:55 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:42909 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751345AbWJBDyz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 23:54:55 -0400
Message-ID: <45208D82.8010606@garzik.org>
Date: Sun, 01 Oct 2006 23:54:42 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: kkeil@suse.de, kai.germaschewski@gmx.de, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ISDN: mark as 32-bit only
References: <20061001152116.GA4684@havoc.gtf.org> <Pine.LNX.4.61.0610012007240.13920@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0610012007240.13920@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>> Tons of ISDN drivers cast pointers to/from 32-bit values, which just
>> won't work on 64-bit.
> 
> Should not that be fixed instead of restricting isdn to 32bit?

It hasn't been fixed in many years, and I don't see anyone stepping up 
to the plate, even with my current trolling...  :)


> Though this is probably the best temporary workaround until someone can 
> fix up all the "tons".

I have a better workaround, I think.

	Jeff



