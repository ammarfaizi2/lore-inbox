Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030306AbWJCLLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030306AbWJCLLT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 07:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030295AbWJCLLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 07:11:18 -0400
Received: from rtr.ca ([64.26.128.89]:44550 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1030306AbWJCLLR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 07:11:17 -0400
Message-ID: <45224554.8030005@rtr.ca>
Date: Tue, 03 Oct 2006 07:11:16 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Andrew Lyon <andrew.lyon@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SATA CD/DVDRW Support in 2.6.18?
References: <f4527be0610010740r662f8d8at4dbbf68d1543040f@mail.gmail.com>
In-Reply-To: <f4527be0610010740r662f8d8at4dbbf68d1543040f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Lyon wrote:
>
> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
..
> It looks like the interface is trying to run at 1.5Gbps which is
> obviously too fast for this drive

No, with SATA the only two choices available today are 1.5gb/s and 3.0gb/s.
The speed-down fault-recovery logic in libata is kinda bogus for genuine SATA.
Something else must be wrong in your situation.
