Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267449AbUBSSEm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 13:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267454AbUBSSEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 13:04:41 -0500
Received: from [192.38.164.146] ([192.38.164.146]:650 "EHLO izzlazz.izzlazz.dk")
	by vger.kernel.org with ESMTP id S267449AbUBSSEk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 13:04:40 -0500
Subject: Re: e1000 (on-board CSA) lockup with 2.6.3 on ifconfig
From: "Rene H. Larsen" <rhl@izzlazz.dk>
To: Alex Scheele <alex@ccbeheer.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000001c3f6dc$ed8ee9b0$3364a8c0@lapas>
References: <000001c3f6dc$ed8ee9b0$3364a8c0@lapas>
Content-Type: text/plain
Message-Id: <1077213878.3170.2.camel@renehl.izzlazz.dk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 19 Feb 2004 19:04:39 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tor, 2004-02-19 kl. 12:38 skrev Alex Scheele:
> Hi,
> 
> The lockup is probably caused by a patch that made it in the tree 
> which adds an interrupt disable/enable to keep interrupt assertion 
> state synced between 82547 and APIC. This patch was in the tree before 
> but was reverted a while back because it locked up 82547 CSA-based LOMs. 
> Apparently it made it back in. Below I have inserted a patch (against 2.6.3)
> which removes it again. Feel free to test if it stops the lockups.

It works like a charm.  My box now boots with kernel 2.6.3.

Thanks a lot!

> Regards,
> 
> Alex Scheele

[patch snipped]

