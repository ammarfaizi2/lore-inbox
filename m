Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264602AbTL3VbD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 16:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265351AbTL3VbC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 16:31:02 -0500
Received: from ms-smtp-02-qfe0.nyroc.rr.com ([24.24.2.56]:25022 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S264602AbTL3Va6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 16:30:58 -0500
Date: Tue, 30 Dec 2003 16:30:50 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.5isms
Message-ID: <20031230213050.GA3301@andromeda>
References: <20030703200134.GA18459@andromeda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030703200134.GA18459@andromeda>
User-Agent: Mutt/1.5.4i
From: Justin Pryzby <justinpryzby@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems I've found another 2.5ism.  2.6.0, arch/i386/kernel/dmi_scan.c
has

#ifdef CONFIG_SIMNOW
        /*
         *      Skip on x86/64 with simnow. Will eventually go away
         *      If you see this ifdef in 2.6pre mail me !
         */
        return -1;
#endif

I don't know whose file this is ..

Also, 2.6.0 still has the previously mentioned problem in
include/asm/io.h.

Not subscribed, CC me.

Justin

On Thu, Jul 03, 2003 at 01:01:34PM -0700, pryzbyj wrote:
> Linux 2.4.21, include/asm/io.h:51 says "Will be removed in 2.4".  Its
> there in 2.5.74 as well.
> 
> I can understand why it would be in 2.5; the comment should say 2.6,
> though.
> 
> Justin
