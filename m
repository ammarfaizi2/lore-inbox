Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030220AbWGaQWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbWGaQWY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 12:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbWGaQWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 12:22:24 -0400
Received: from xenotime.net ([66.160.160.81]:54447 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030220AbWGaQWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 12:22:23 -0400
Date: Mon, 31 Jul 2006 09:25:03 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: armbru@redhat.com, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix trivial unwind info bug
Message-Id: <20060731092503.8e65048e.rdunlap@xenotime.net>
In-Reply-To: <E1G7Z8C-0007IO-00@gondolin.me.apana.org.au>
References: <874px31tz4.fsf@pike.pond.sub.org>
	<E1G7Z8C-0007IO-00@gondolin.me.apana.org.au>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Aug 2006 00:52:32 +1000 Herbert Xu wrote:

> Markus Armbruster <armbru@redhat.com> wrote:
> > CFA needs to be adjusted upwards for push, and downwards for pop.
> > arch/i386/kernel/entry.S gets it wrong in one place.
> > 
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> 
> Thanks for the patch Markus.  Andi Kleen is now maintaining i386
> so please cc him in future for i386 patches.

Oh, that's clearer than what I heard.  Please add it to
MAINTAINERS.

Thanks,
---
~Randy
