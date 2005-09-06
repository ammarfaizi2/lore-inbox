Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932468AbVIFNcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbVIFNcN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 09:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbVIFNcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 09:32:13 -0400
Received: from main.gmane.org ([80.91.229.2]:50843 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932468AbVIFNcM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 09:32:12 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>
Subject: Re: RFC: i386: kill !4KSTACKS
Date: Tue, 06 Sep 2005 09:25:55 -0400
Message-ID: <dfk5cp$19p$1@sea.gmane.org>
References: <20050904145129.53730.qmail@web50202.mail.yahoo.com> <1125854398.23858.51.camel@localhost.localdomain> <p73aciqrev0.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: lmcgw.cs.sunysb.edu
User-Agent: KNode/0.9.90
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> AFAIK with interrupt stacks it shouldn't be a big issue to switch
> to a private bigger stack. ndiswrapper just needs to have its own private
> way to do "current" which accesses thread_info at the bottom of the stack.

I am developer of ndiswrapper and just caught up with this discussion. I am
interested in providing private stack for ndiswrapper. I am not familiar
with linux kernel internals to understand your proposal. Could you give me
details please: If you can give a rough sketch of idea, I can implement it.
Better yet, if you (or anyone else) can provide an implementation (not
necessarily against ndsiwrapper, but a proof of concept), it will be
greatly appreciated - this should also help any other projects that need
more than 4k stack.

Thanks,
Giri.



