Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267438AbUG2VaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267438AbUG2VaL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 17:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265256AbUG2V21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 17:28:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:55744 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267438AbUG2VZS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 17:25:18 -0400
Date: Thu, 29 Jul 2004 14:28:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org, riel@redhat.com,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: [patch] mlock-as-nonroot revisted
Message-Id: <20040729142829.2a75c9b9.akpm@osdl.org>
In-Reply-To: <20040729100307.GA23571@devserv.devel.redhat.com>
References: <20040729100307.GA23571@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjanv@redhat.com> wrote:
>
> Below is a fixed up patch to allow non-root to mlock memory

I seem to recall that Andrea identified reasons why per-user mlock limits
were fundamentally broken/unsuitable, but I forget the details.  Perhaps he
could remind us?

As for this patch: it's a new capability which will get basically zero
testing for the next year, which is a worry.  How have you tested it, and
how much?
