Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262903AbUDANij (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 08:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262907AbUDANij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 08:38:39 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:44251
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262903AbUDANii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 08:38:38 -0500
Date: Thu, 1 Apr 2004 15:38:37 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, Bongani Hlope <bonganilinux@mweb.co.za>
Subject: Re: 2.6.5-rc3-aa1
Message-ID: <20040401133837.GD18585@dualathlon.random>
References: <20040331030921.GA2143@dualathlon.random> <20040331211620.19a8f725@bongani> <200404011157.33051@WOLK>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404011157.33051@WOLK>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 11:57:33AM +0200, Marc-Christian Petersen wrote:
> On Wednesday 31 March 2004 21:16, Bongani Hlope wrote:
> 
> Hi Bongani,
> 
> > I'm running 2.6.5-rc2-aa4, when I woke-up in the morning almost all of my
> > memory was gone, but my swap was never touched. I managed to get only the
> > output of SysRq-M before it hard-locked. For some reason it doesn't swap.
> > I'll try to reproduce.
> 
> hmm, I am running 2.6.5-rc3-aa1 stuff ontop of 2.6.5-rc3-mm3. It works very 
> well. What is the value of /proc/sys/vm/swappiness?

my script is swapping well for him too, so maybe this was more a
genuine deadlock somewhere than something else, it would been
interesting to see SYSRQ+P. It's not necessairly related to my changes.
