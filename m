Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbVJFJsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbVJFJsR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 05:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbVJFJsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 05:48:17 -0400
Received: from cantor.suse.de ([195.135.220.2]:30597 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750762AbVJFJsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 05:48:15 -0400
From: Andi Kleen <ak@suse.de>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.14-rc3-rt2
Date: Thu, 6 Oct 2005 11:48:02 +0200
User-Agent: KMail/1.8
Cc: Ingo Molnar <mingo@elte.hu>, Mark Knecht <markknecht@gmail.com>,
       linux-kernel@vger.kernel.org
References: <20051004130009.GB31466@elte.hu> <20051006081055.GA20491@elte.hu> <Pine.LNX.4.58.0510060433010.28535@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.58.0510060433010.28535@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510061148.03098.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[hrm - should read whole threads before replying]


>
> So a u32 flags with
>
>   flags = acpi_os_acquire_lock(lock);
>
> would be safe, unless a 64 bit machine stored the value of IR in the upper
> word, which I don't know of any archs that do that.

At least on x86-64 it should be ok.

-Andi
