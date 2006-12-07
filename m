Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163309AbWLGUji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163309AbWLGUji (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 15:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163312AbWLGUji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 15:39:38 -0500
Received: from smtp.osdl.org ([65.172.181.25]:36978 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163309AbWLGUjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 15:39:37 -0500
Date: Thu, 7 Dec 2006 12:38:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>,
       linux-kernel@vger.kernel.org, ak@suse.de,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] x86_64: do not enable the NMI watchdog by default
Message-Id: <20061207123836.213c3214.akpm@osdl.org>
In-Reply-To: <20061207123011.4b723788@localhost.localdomain>
References: <20061206223025.GA17227@elte.hu>
	<200612061857.30248.len.brown@intel.com>
	<20061207121135.GA15529@elte.hu>
	<20061207123011.4b723788@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2006 12:30:11 +0000
Alan <alan@lxorguk.ukuu.org.uk> wrote:

> On Thu, 7 Dec 2006 13:11:35 +0100
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > or via the nmi_watchdog=1 or nmi_watchdog=2 boot options.
> > 
> > build and boot tested on an Athlon64 box.
> > 
> > Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
> Acked-by: Alan Cox <alan@redhat.com>

metoo.  I'm really struggling to recall an occasion on which the NMI
watchdog helped diagnose or fix a bug.  The usual scenario nowadays is that
I ask a reporter to enable NMI watchdog and for various reasons (mostly
mysterious) no useful information comes of it.

If it's causing machines to go down then the current tradeoff doesn't seem
right.

But _is_ it causing machines to go down, after the ACPI fix?

(the patch doesn't vaguely apply btw).
