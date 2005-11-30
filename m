Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbVK3B5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbVK3B5I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 20:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbVK3B5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 20:57:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:25498 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750777AbVK3B5H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 20:57:07 -0500
Date: Tue, 29 Nov 2005 17:57:00 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Stephen Hemminger <shemminger@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org, rjw@sisk.pl
Subject: Re: Linux 2.6.15-rc3
In-Reply-To: <20051129164222.66d00ca1@dxpl.pdx.osdl.net>
Message-ID: <Pine.LNX.4.64.0511291754350.3135@g5.osdl.org>
References: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org> <200511292247.09243.rjw@sisk.pl>
 <200511292342.36228.rjw@sisk.pl> <20051129145328.3e5964a4@dxpl.pdx.osdl.net>
 <20051129233744.GA32316@kroah.com> <20051129161731.69ce252c@dxpl.pdx.osdl.net>
 <20051129162519.1ef07387.akpm@osdl.org> <20051129164222.66d00ca1@dxpl.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 29 Nov 2005, Stephen Hemminger wrote:
> 
> Yes, when I retested with the usb patch it was against a fresh git pull.
> So it probably isn't a USB problem but something that got introduced between
> the two (2.6.15-rc3 vs latest).
> 
> I'll go back to the 2.6.15-rc3 tree and test usb fix.

Can you check the current -git tree ( + the usb fix, which has _not_ made 
it there yet). I think it was probably the stupid thinko that just didn't 
trigger for me on ppc64 since it only breaks with 4-level page tables.

		Linus
