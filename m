Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbUBWXmf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 18:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbUBWXmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 18:42:35 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:53685 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262089AbUBWXmd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 18:42:33 -0500
Subject: Re: 2.6.3 vs. ibm xseries 445 (4 way)
From: john stultz <johnstul@us.ibm.com>
To: "Max Paynemax.." <payne@freemail.hu>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <freemail.20040123144654.89434@fm1.freemail.hu>
References: <freemail.20040123144654.89434@fm1.freemail.hu>
Content-Type: text/plain
Message-Id: <1077579744.1983.2.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 23 Feb 2004 15:42:25 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-02-23 at 05:46, Max Payne wrote:
> Hardware:
> 
> ibm xseries 445, 4 way intel pentium xeon 3GHz, 8GB RAM
> 
> with SuSE Linux SLES8 (2.4.19-64GB-SMP kernel) everything is
> OK, i have 4 CPU (reported by "cat /proc/cpuinfo" and "top") 
> 
> with vanilla 2.6.3 i have only one CPU. Yes, SMP kernel. Any
> idea?

Under "Processor type and features" make sure "Subarchitecture Type" is
set to "Summit/EXA" or "Generic"

Hope that helps, and please let me know if you have any further
problems.

thanks
-john


