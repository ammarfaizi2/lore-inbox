Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbWH1Xqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbWH1Xqu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 19:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbWH1Xqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 19:46:50 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:44475 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S964890AbWH1Xqt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 19:46:49 -0400
Subject: Re: boot failure, "DWARF2 unwinder stuck at 0xc0100199"
From: Badari Pulavarty <pbadari@gmail.com>
To: Andi Kleen <ak@suse.de>
Cc: Jan Beulich <jbeulich@novell.com>, Andrew Morton <akpm@osdl.org>,
       "J. Bruce Fields" <bfields@fieldses.org>,
       lkml <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>
In-Reply-To: <200608290054.47781.ak@suse.de>
References: <20060820013121.GA18401@fieldses.org>
	 <44EAD613.76E4.0078.0@novell.com>
	 <1156804352.447.5.camel@dyn9047017100.beaverton.ibm.com>
	 <200608290054.47781.ak@suse.de>
Content-Type: text/plain
Date: Mon, 28 Aug 2006 16:50:00 -0700
Message-Id: <1156809000.447.20.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-29 at 00:54 +0200, Andi Kleen wrote:
> Thanks for the test cases. If you have more keep them comming.
> 
...
> > 
> > Call Trace:
> >  [<ffffffff8020ad7f>] show_trace+0xae/0x30e
> >  [<ffffffff8020aff4>] dump_stack+0x15/0x17
> >  [<ffffffff802288a5>] __might_sleep+0xb2/0xb4
> >  [<ffffffff8024750e>] down_read+0x1d/0x2f
> >  [<ffffffff8023e674>] blocking_notifier_call_chain+0x1b/0x41
> >  [<ffffffff80232511>] profile_task_exit+0x15/0x17
> >  [<ffffffff80233f95>] do_exit+0x25/0x91e
> >  [<ffffffff8020b222>] kernel_math_error+0x0/0x96
> >  [<ffff81010b6a30c0>]
> 
> 
> Hmm, not sure about that one. In theory it should have been fixed
> in rc4 already. Was this from an earlier kernel?
> 

No. All these traces are from -rc4.

Thanks,
Badari

