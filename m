Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264512AbUGYVmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264512AbUGYVmx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 17:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264519AbUGYVmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 17:42:53 -0400
Received: from posti5.jyu.fi ([130.234.4.34]:17590 "EHLO posti5.jyu.fi")
	by vger.kernel.org with ESMTP id S264512AbUGYVmv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 17:42:51 -0400
Date: Mon, 26 Jul 2004 00:42:41 +0300 (EEST)
From: Pasi Sjoholm <ptsjohol@cc.jyu.fi>
X-X-Sender: ptsjohol@silmu.st.jyu.fi
To: "Will S." <willgs00@cox.net>
cc: akpm@osdl.org, <linux-kernel@vger.kernel.org>
Subject: Re: ksoftirqd uses 99% CPU triggered by network traffic (maybe
 RLT-8139 related)
In-Reply-To: <4104257C.3080102@cox.net>
Message-ID: <Pine.LNX.4.44.0407260032240.4782-100000@silmu.st.jyu.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Checked: by miltrassassin
	at posti5.jyu.fi; Mon, 26 Jul 2004 00:42:43 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jul 2004, Will S. wrote:

>>Yeah, it might be some sort of a bug which is related to 
>>VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]-chipset and 
>>RTL-8139? Hard to say at this point. I'll get some other network cards 
>>tomorrow from the office and we will see if there is a difference. 
>>I hope that it's not the mobo (chipset). =)

> I just remembered something. In the kernel config, there's an option for 
> the RTL-8139 driver to use polling I/O instead of memory mapped I/O - 
> and it usually defaults to PIO. My kernel was compiled using the MMIO 
> option. Check and see what you're using.

I'm using MMIO-option, I was just thinking to go with the PIO and see what 
will happen.

I just found this thread (url below) and some others are having problems 
also.

http://seclists.org/lists/linux-kernel/2004/Mar/2295.html

Andrew:

Did you find any solution to this one? (I guess not but could I be in help 
someway to hunt this bug down?)


