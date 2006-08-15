Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030318AbWHOOmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030318AbWHOOmD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 10:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030322AbWHOOmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 10:42:03 -0400
Received: from mail.suse.de ([195.135.220.2]:2527 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030318AbWHOOmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 10:42:01 -0400
To: Arjan van de Ven <arjan@infradead.org>
Cc: hugh@veritas.com, akpm@osdl.org, dmccr@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: Shared page tables patch... some results
References: <1155638047.3011.96.camel@laptopd505.fenrus.org>
From: Andi Kleen <ak@suse.de>
Date: 15 Aug 2006 16:41:46 +0200
In-Reply-To: <1155638047.3011.96.camel@laptopd505.fenrus.org>
Message-ID: <p73wt9a83it.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:
> and the result is interesting:
> Just booting into runlevel 5 and logging into gnome (without starting
> any apps) gets a sharing of 1284 pte pages! This means that five
> megabytes (!!) of memory is saved, and countless pagefaults are avoided.
>

When I start SLES10 GNOME after boot with one firefox window and
one gnome terminal I only have ~5.3MB in total page tables according
to /proc/meminfo

You're saying you can share 5MB of those. Call me sceptical of your
numbers.

-Andi
