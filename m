Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbWFIC4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbWFIC4R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 22:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWFIC4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 22:56:17 -0400
Received: from xenotime.net ([66.160.160.81]:63655 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751370AbWFIC4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 22:56:16 -0400
Date: Thu, 8 Jun 2006 19:59:02 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Barry Scott <barry.scott@onelan.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc6 Section mismatch warnings
Message-Id: <20060608195902.26902ef0.rdunlap@xenotime.net>
In-Reply-To: <4488057A.9090301@onelan.co.uk>
References: <4488057A.9090301@onelan.co.uk>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Jun 2006 12:09:46 +0100 Barry Scott wrote:

> When I built 2.6.17-rc6 I see a lot of warnings after the MODPOST message
> about Section mismatch. What did I do wrong in building the kernel and 
> modules?
...
> Here are some of the warnings:

It would be helpful if someone could look at/work on the
section mismatches in the isdn and sound drivers...

I have 6 new patches to post, then I'll be
sweeping the net drivers soon.

> WARNING: drivers/scsi/megaraid/megaraid_mbox.o - Section mismatch: 
> reference to .init.text: from .text between 'megaraid_probe_one' (at 
> offset 0x1f00) and 'megaraid_queue_command'

Can you see if
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc6/2.6.17-rc6-mm1/broken-out/megaraid_mbox-fix-section-mismatch-warnings.patch
fixes the megaraid warning for you?



---
~Randy
