Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWITR5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWITR5T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWITR5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:57:19 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:44944
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932177AbWITR5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:57:18 -0400
Date: Wed, 20 Sep 2006 10:56:59 -0700 (PDT)
Message-Id: <20060920.105659.128612840.davem@davemloft.net>
To: simoneau@ele.uri.edu
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [sparc64] 2.6.18 unaligned acccess in ehci_hub_control
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060920172123.GA9334@ele.uri.edu>
References: <20060920172123.GA9334@ele.uri.edu>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Simoneau <simoneau@ele.uri.edu>
Date: Wed, 20 Sep 2006 13:21:23 -0400

> I upgraded from 2.6.17.7 to 2.6.18 today, and in dmesg I have 5 of these
> messages in a row:
> 
> Kernel unaligned access at TPC[100be8c8] ehci_hub_control+0x350/0x680 [ehci_hcd]
> 
> This message wasn't there before... I suppose it is pretty harmless as
> the kernel is supposed to handle unaligned accesses (right?) but this is
> the first time it's happened.

Yes, I've been meaning to send Greg KH patches to fix these
cases, thanks for reminding me about it.
