Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266138AbUAQUwI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 15:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266145AbUAQUwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 15:52:08 -0500
Received: from colin2.muc.de ([193.149.48.15]:10511 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S266138AbUAQUwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 15:52:06 -0500
Date: 17 Jan 2004 21:53:02 +0100
Date: Sat, 17 Jan 2004 21:53:02 +0100
From: Andi Kleen <ak@colin2.muc.de>
To: Sander <sander@humilis.net>
Cc: Andi Kleen <ak@muc.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       jh@suse.cz
Subject: Re: several oopses during boot (was: Re: [PATCH] Add CONFIG for -mregparm=3)
Message-ID: <20040117205302.GA16658@colin2.muc.de>
References: <20040114090603.GA1935@averell> <20040117201639.GA16420@favonius>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040117201639.GA16420@favonius>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.6.1-mm4

Note that this kernel is broken on gcc 3.4 and on 3.3-hammer. If you're
using that disable the -funit-at-a-time setting in the main Makefile.

> VIA C3 Ezra
> 
> It mounts its root filesystem over nfs and has netconsole compiled in.
> 
> Without the REGPARM option the system boots and runs fine.
> 
> Should I post the oopses, the result of ksymoops, a dmesg and kernel
> config or is this an already known issue?

Not known. Please post the decoded oopses.  Also give your compiler
version.

-Andi
