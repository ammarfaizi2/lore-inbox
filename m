Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbWARCrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbWARCrc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 21:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbWARCrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 21:47:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41919 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964854AbWARCra (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 21:47:30 -0500
Date: Tue, 17 Jan 2006 18:46:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Patrick McHardy <kaber@trash.net>
Cc: mingo@elte.hu, laforge@netfilter.org, coreteam@netfilter.org,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [netfilter-core] [patch 2.6.15-mm4] sem2mutex: netfilter
 x_table.c
Message-Id: <20060117184654.2e0f7469.akpm@osdl.org>
In-Reply-To: <43CDA834.3070301@trash.net>
References: <20060114143042.GA17675@elte.hu>
	<43CDA834.3070301@trash.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McHardy <kaber@trash.net> wrote:
>
> Ingo Molnar wrote:
> > From: Ingo Molnar <mingo@elte.hu>
> > 
> > semaphore to mutex conversion.
> > 
> > the conversion was generated via scripts, and the result was validated
> > automatically via a script as well.
> 
> I haven't followed all the mutex patches, is this intended
> for mainline or for -mm?

You're probably better off ignoring it all for now.  Once things have
settled down and all the sem2mutex patches have been finalised and
reasonably tested I'll send whatever hasn't been merged into subsystem
trees over to the relevant maintainers.

http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt might help
shed some light on the intricacies of -mm patches.
