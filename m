Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265877AbUFOTPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265877AbUFOTPm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 15:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265880AbUFOTPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 15:15:42 -0400
Received: from [82.147.40.124] ([82.147.40.124]:59295 "EHLO dodge.jordet.nu")
	by vger.kernel.org with ESMTP id S265877AbUFOTPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 15:15:32 -0400
Subject: Re: Oopses with both recent 2.4.x kernels and 2.6.x kernels
From: Stian Jordet <liste@jordet.nu>
To: Nick Warne <nick@ukfsn.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40CF43A6.5170.28D6B4D5@localhost>
References: <40CF43A6.5170.28D6B4D5@localhost>
Content-Type: text/plain
Date: Tue, 15 Jun 2004 21:15:26 +0200
Message-Id: <1087326926.9402.3.camel@chevrolet.jordet>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tir, 15.06.2004 kl. 18.44 +0100, skrev Nick Warne:
> But, after talking to a member of the HantsLUG, and showing logs and 
> stuff, he brought up at the swap size.  This box was once 64Mb, but 
> is now 128Mb - with 128Mb swap.  I created an additional swap file 
> (256Mb), and (touch wood), no oops since, all heathly :)  I never 
> looked at this before, as swap was never used _during_ normal running 
> of the box, but as he said maybe the cron.weekly ran a lot of stuff 
> that did use it up...

Doubt that has been my problem... The box in question had 180 MB ram,
and 512 MB swap. The script can't have used that much.. And even if it
did, it is a bug that the box oopses and dies, I guess.

Best regards,
Stian

