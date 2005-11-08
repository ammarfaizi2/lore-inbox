Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965231AbVKHVib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965231AbVKHVib (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 16:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965237AbVKHVib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 16:38:31 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:11479 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S965231AbVKHVia
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 16:38:30 -0500
Subject: Re: athlon x2 + 2.6.14 + SMP = fast clock
From: john stultz <johnstul@us.ibm.com>
To: Christopher Mulcahy <cmulcahy@avesi.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1131482417.21752.50.camel@jones>
References: <1131482417.21752.50.camel@jones>
Content-Type: text/plain
Date: Tue, 08 Nov 2005 13:38:23 -0800
Message-Id: <1131485903.27168.662.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-08 at 15:40 -0500, Christopher Mulcahy wrote:
> I am running 2.6.14 SMP on an dual-core athlon x2 3800.
> The system clock runs at roughly twice normal speed.

Is this a new regression or did the problem occur with 2.6.13 or older
kernels?

Would you mind opening a kernel bug and attaching your dmesg and config?

http://bugzilla.kernel.org


Also try booting w/ "idle=poll" to see if that doesn't clear up the
issue.

thanks
-john



