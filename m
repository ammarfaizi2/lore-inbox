Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbTLPNWt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 08:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbTLPNWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 08:22:48 -0500
Received: from intra.cyclades.com ([64.186.161.6]:31979 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S261575AbTLPNWs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 08:22:48 -0500
Date: Tue, 16 Dec 2003 11:08:52 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Kristian Peters <kristian.peters@korseby.net>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Peter Bergmann <bergmann.peter@gmx.net>, <linux-kernel@vger.kernel.org>,
       <nfedera@esesix.at>, <andrea@suse.de>, <riel@redhat.com>
Subject: Re: Configurable OOM killer Re: old oom-vm for 2.4.32 (was oom killer
  in 2.4.23)
In-Reply-To: <20031209193412.39c1ca71.kristian.peters@korseby.net>
Message-ID: <Pine.LNX.4.44.0312161056110.1533-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Dec 2003, Kristian Peters wrote:

> Marcelo Tosatti <marcelo.tosatti@cyclades.com> schrieb:
> > The following patch makes OOM killer configurable (its the same as the 
> > other patches posted except its around CONFIG_OOM_KILLER).
> > 
> > I hope the Configure.help entry is clear enough.
> 
> What about the PF_MEMDIE issues Andrea has argued ? Are they solved by the added code in page_alloc.c ?
> 
> As Andrea has pointed out earlier, a yield() after out_of_memory() is safe and should be added too.

out_of_memory() calls yield() so its not necessary. 

