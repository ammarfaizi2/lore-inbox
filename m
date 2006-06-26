Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933017AbWFZUN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933017AbWFZUN5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 16:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933013AbWFZUN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 16:13:56 -0400
Received: from 1wt.eu ([62.212.114.60]:20489 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S933018AbWFZUNz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 16:13:55 -0400
Date: Mon, 26 Jun 2006 22:01:20 +0200
From: Willy Tarreau <w@1wt.eu>
To: morrowc+kernel@ops-netman.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: crashes of 2.4.31 kernel (oops included)
Message-ID: <20060626200120.GK13255@w.ods.org>
References: <Pine.LNX.4.61.0606260544000.10457@arb-h2.bcf-argzna.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0606260544000.10457@arb-h2.bcf-argzna.arg>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Jun 26, 2006 at 05:52:37AM +0000, morrowc+kernel@ops-netman.net wrote:
> >From URL - http://kernel.org/pub/linux/docs/lkml/reporting-bugs.html
> 
> [1.] One line summary of the problem: kernel panic/oops system hangs
> [2.] Full description of the problem/report:
> After some random period of time (from 1 hour to several days) kernel 
> receives an 'oops' and dies. Requires power cycle to recover. I've a few 
> of the 'oops' output saved and converted with ksymoops if required 
> (included one below) Error appear to be in the iptables 
> connection_tracking  actually.
> 
> [3.] Keywords (i.e., modules, networking, kernel):
> networking kernel oops
> [4.] Kernel version (from /proc/version):
> Linux version 2.4.31 (root@neo-u2.ops-netman.net) (gcc version 3.3.5 
> (Debian 1:3.3.5-13)) #1 SMP Sun Mar 12 15:09:22 GMT 2006

Many bugs have been fixed in netfilter code since 2.4.31, you should
really upgrade, either to 2.4.33-rc2, or to 2.4.31-hf32.6 which contains
adds to 2.4.31 all relevant fixes till two weeks ago. You can find it
here : http://linux.exosec.net/kernel/2.4-hf/

If the problem is new, it can indicate a hardware problem, or someone
succeeding in exploiting one of those old bugs.

Regards,
Willy

