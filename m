Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754856AbWKKSUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754856AbWKKSUS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 13:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754860AbWKKSUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 13:20:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3034 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1754856AbWKKSUR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 13:20:17 -0500
Date: Sat, 11 Nov 2006 10:19:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: David Howells <dhowells@redhat.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       "bugme-daemon@kernel-bugs.osdl.org" 
	<bugme-daemon@bugzilla.kernel.org>,
       linux-kernel@vger.kernel.org, alex@hausnet.ru
Subject: Re: [Bugme-new] [Bug 7495] New: Kernel periodically hangs.
Message-Id: <20061111101942.5f3f2537.akpm@osdl.org>
In-Reply-To: <1163268603.3293.45.camel@laptopd505.fenrus.org>
References: <200611111129.kABBTWgp014081@fire-2.osdl.org>
	<20061111100038.6277efd4.akpm@osdl.org>
	<1163268603.3293.45.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Nov 2006 19:10:03 +0100
Arjan van de Ven <arjan@infradead.org> wrote:

> > > Kernel started with noapic option, cause it hands on load without this option.
> > 
> > Him and a million other people.  I know we broke APIC.  Around 2.6.9, I
> > think.
> 
> 
> is that when the "enable apic even on UP so that distro kernels can
> install on the ibm x44*" patches went in?
> 

I don't know.  In fact I forget how I worked out that it worsened in
2.6.early.

google(noapic) gets 232,000 hits.

I don't think it really matters when or why it happened.  If we take the
approach of fixing one machine at a time, we'll only need to fix a few
individual machines to improve the situation for a lot of people.

