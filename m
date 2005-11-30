Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbVK3CJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbVK3CJv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 21:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbVK3CJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 21:09:51 -0500
Received: from ozlabs.org ([203.10.76.45]:49028 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750782AbVK3CJu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 21:09:50 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17293.2534.764441.128963@cargo.ozlabs.ibm.com>
Date: Wed, 30 Nov 2005 13:09:42 +1100
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Stephen Hemminger <shemminger@osdl.org>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, linux-kernel@vger.kernel.org, rjw@sisk.pl
Subject: Re: Linux 2.6.15-rc3
In-Reply-To: <Pine.LNX.4.64.0511291754350.3135@g5.osdl.org>
References: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org>
	<200511292247.09243.rjw@sisk.pl>
	<200511292342.36228.rjw@sisk.pl>
	<20051129145328.3e5964a4@dxpl.pdx.osdl.net>
	<20051129233744.GA32316@kroah.com>
	<20051129161731.69ce252c@dxpl.pdx.osdl.net>
	<20051129162519.1ef07387.akpm@osdl.org>
	<20051129164222.66d00ca1@dxpl.pdx.osdl.net>
	<Pine.LNX.4.64.0511291754350.3135@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> Can you check the current -git tree ( + the usb fix, which has _not_ made 
> it there yet). I think it was probably the stupid thinko that just didn't 
> trigger for me on ppc64 since it only breaks with 4-level page tables.

Unless you have selected 64k pages (I assume not), ppc64 does use
4-level page tables.

Paul.
