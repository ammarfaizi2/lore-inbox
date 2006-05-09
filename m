Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbWEIVmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWEIVmR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 17:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWEIVmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 17:42:17 -0400
Received: from ns2.suse.de ([195.135.220.15]:48577 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751170AbWEIVmQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 17:42:16 -0400
From: Andi Kleen <ak@suse.de>
To: dzickus <dzickus@redhat.com>
Subject: Re: [patch 4/8] Add SMP support on x86_64 to reservation framework
Date: Tue, 9 May 2006 23:42:09 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, oprofile-list@lists.sourceforge.net
References: <20060509205035.446349000@drseuss.boston.redhat.com> <20060509205957.139950000@drseuss.boston.redhat.com>
In-Reply-To: <20060509205957.139950000@drseuss.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605092342.09698.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 May 2006 22:50, dzickus wrote:
> 
> This patch includes the changes to make the nmi watchdog on x86_64 SMP
> aware.  A bunch of code was moved around to make it simpler to read.  In
> addition, it is now possible to determine if a particular NMI was the result
> of the watchdog or not.  This feature allows the kernel to filter out
> unknown NMIs easier. 


Looks all good to me. I merged it all up. Thanks.

Regarding the ioapic watchdog not switching with the sysctl - i guess
we can live with that. It is deprecated anyways.

Thanks for doing all that work.

-Andi

