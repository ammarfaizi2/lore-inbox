Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262930AbTDFLMd (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 07:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbTDFLMd (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 07:12:33 -0400
Received: from holomorphy.com ([66.224.33.161]:3226 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262930AbTDFLMc (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 07:12:32 -0400
Date: Sun, 6 Apr 2003 04:23:40 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Robert Love <rml@tech9.net>,
       Martin Bligh <mbligh@aracnet.com>
Subject: Re: 2.5.65-preempt booting on 32way NUMAQ
Message-ID: <20030406112340.GM993@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Robert Love <rml@tech9.net>, Martin Bligh <mbligh@aracnet.com>
References: <Pine.LNX.4.50.0304060625130.2268-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0304060625130.2268-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 06, 2003 at 06:48:33AM -0400, Zwane Mwaikambo wrote:
> Robert i suppose you can add another notch on your erm.. bedpost(?) 
> and congratulations to all the kernel developers! It survived some 
> local networking stress tests, but there is more fun stuff like tty 
> layer to completely obliterate ;)

Wow!

This has had a hard time historically. I'm really glad NUMA-Q's are now
immune (in the sense of correctness) to this config; previously it was
believed that preemption points in printk(linux_banner) would take out
the machine early in boot if preemption was enabled.

Congratulations rml!

If you're booting without issues on these things, you are a _very_ long
way toward being race-free. This is incredibly good news, both for the
preemption support, and for the general stability of the i386 bootstrap.

All that's really left is driver and non-i386 arch coverage if I'm right.


-- wli
