Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbUCTE0Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 23:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263229AbUCTE0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 23:26:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:48337 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263228AbUCTE0P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 23:26:15 -0500
Date: Fri, 19 Mar 2004 20:26:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Len Brown <len.brown@intel.com>
Cc: markw@osdl.org, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm2
Message-Id: <20040319202616.21108d17.akpm@osdl.org>
In-Reply-To: <1079756340.7277.631.camel@dhcppc4>
References: <A6974D8E5F98D511BB910002A50A6647615F5E26@hdsmsx402.hd.intel.com>
	<1079756340.7277.631.camel@dhcppc4>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown <len.brown@intel.com> wrote:
>
> On Fri, 2004-03-19 at 21:53, Mark Wong wrote:
> 
> > > Thanks, so it's the CPU scheduler changes.  Is that machine
> > hyperthreaded? 
> > > And do you have CONFIG_X86_HT enabled?
> > 
> > Yes and CONFIG_X86_HT is enabled but I have hyperthreading disabled
> > with
> > 'acpi=off noht' (whichever one does it.)  
> 
> CONFIG_X86_HT=y does not enable HT.
> CONFIG_X86_HT=n does not disable HT.
> It only controls if the cpu_sibling_map[] etc. are initialized.

Err, the question I meant to ask Mark was "do you have CONFIG_SCHED_SMT
enabled?"
