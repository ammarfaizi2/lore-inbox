Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030246AbWF0APK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbWF0APK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 20:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030248AbWF0APJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 20:15:09 -0400
Received: from neo-u2.ops-netman.net ([63.95.249.169]:63167 "EHLO
	neo-u2.ops-netman.net") by vger.kernel.org with ESMTP
	id S1030246AbWF0APH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 20:15:07 -0400
Date: Tue, 27 Jun 2006 00:15:00 +0000 (GMT)
From: Chris Morrow <morrowc@ops-netman.net>
To: Willy Tarreau <w@1wt.eu>
Cc: morrowc+kernel@ops-netman.net, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: crashes of 2.4.31 kernel (oops included)
In-Reply-To: <20060626200120.GK13255@w.ods.org>
Message-ID: <Pine.LNX.4.61.0606270011360.27822@arb-h2.bcf-argzna.arg>
References: <Pine.LNX.4.61.0606260544000.10457@arb-h2.bcf-argzna.arg>
 <20060626200120.GK13255@w.ods.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 Jun 2006, Willy Tarreau wrote:

> Hello,
>
> On Mon, Jun 26, 2006 at 05:52:37AM +0000, morrowc+kernel@ops-netman.net wrote:
>>> From URL - http://kernel.org/pub/linux/docs/lkml/reporting-bugs.html
>>
>> [1.] One line summary of the problem: kernel panic/oops system hangs
>> [2.] Full description of the problem/report:
>> After some random period of time (from 1 hour to several days) kernel
>> receives an 'oops' and dies. Requires power cycle to recover. I've a few
>> of the 'oops' output saved and converted with ksymoops if required
>> (included one below) Error appear to be in the iptables
>> connection_tracking  actually.
>>
>> [3.] Keywords (i.e., modules, networking, kernel):
>> networking kernel oops
>> [4.] Kernel version (from /proc/version):
>> Linux version 2.4.31 (root@neo-u2.ops-netman.net) (gcc version 3.3.5
>> (Debian 1:3.3.5-13)) #1 SMP Sun Mar 12 15:09:22 GMT 2006
>
> Many bugs have been fixed in netfilter code since 2.4.31, you should
> really upgrade, either to 2.4.33-rc2, or to 2.4.31-hf32.6 which contains
> adds to 2.4.31 all relevant fixes till two weeks ago. You can find it
> here : http://linux.exosec.net/kernel/2.4-hf/

ah-ha :( ok, so I'll upgrade and watch for any new failures, thanks for 
the prompt attention :)

>
> If the problem is new, it can indicate a hardware problem, or someone
> succeeding in exploiting one of those old bugs.

thanks again.
