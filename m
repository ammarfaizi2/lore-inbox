Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266192AbUAQV2G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 16:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266195AbUAQV2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 16:28:06 -0500
Received: from colin2.muc.de ([193.149.48.15]:51975 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S266192AbUAQV2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 16:28:02 -0500
Date: 17 Jan 2004 22:28:57 +0100
Date: Sat, 17 Jan 2004 22:28:57 +0100
From: Andi Kleen <ak@colin2.muc.de>
To: Sander <sander@humilis.net>
Cc: Andi Kleen <ak@muc.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       jh@suse.cz
Subject: Re: several oopses during boot (was: Re: [PATCH] Add CONFIG for -mregparm=3)
Message-ID: <20040117212857.GA28114@colin2.muc.de>
References: <20040114090603.GA1935@averell> <20040117201639.GA16420@favonius> <20040117205302.GA16658@colin2.muc.de> <20040117210715.GA15172@favonius>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040117210715.GA15172@favonius>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 17, 2004 at 10:07:15PM +0100, Sander wrote:
> Andi Kleen wrote (ao):
> > > 2.6.1-mm4
> > 
> > Note that this kernel is broken on gcc 3.4 and on 3.3-hammer. If
> > you're using that disable the -funit-at-a-time setting in the main
> > Makefile.
> 
> > > VIA C3 Ezra
> > > 
> > > It mounts its root filesystem over nfs and has netconsole compiled
> > > in.
> > > 
> > > Without the REGPARM option the system boots and runs fine.
> > > 
> > > Should I post the oopses, the result of ksymoops, a dmesg and kernel
> > > config or is this an already known issue?
> > 
> > Not known. Please post the decoded oopses.  Also give your compiler
> > version.
> 
> Hope this helps. The system runs fine with the option disabled.

Can you perhaps save your .config, do a make distclean and try
to compile the kernel from scratch again? Maybe you had some stale object
files around. 

-Andi
