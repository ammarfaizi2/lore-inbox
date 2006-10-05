Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751703AbWJERR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703AbWJERR5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 13:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbWJERR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 13:17:57 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:57323 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751728AbWJERR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 13:17:56 -0400
Message-ID: <45253E37.6070305@garzik.org>
Date: Thu, 05 Oct 2006 13:17:43 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: torvalds@osdl.org, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: Please pull x86-64 bug fixes
References: <200610051910.25418.ak@suse.de>
In-Reply-To: <200610051910.25418.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Linus,
> 
> Please pull 'for-linus' from 
> 
>   git://one.firstfloor.org/home/andi/git/linux-2.6
> 
> Andi Kleen:
>       x86-64: Update defconfig
>       i386: Update defconfig
>       i386: Fix PCI BIOS config space access

Does this fix the following issue:

PCI: BIOS Bug: MCFG area at e0000000 is not E820-reserved
PCI: Not using MMCONFIG.

100% of my x86-64 boxes, AMD or Intel, print this message.  And 100% of 
them work just fine with MMCONFIG.

I think this rule is far too drastic for real life.

	Jeff


