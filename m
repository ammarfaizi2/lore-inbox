Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264183AbUFBVOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264183AbUFBVOc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 17:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264182AbUFBVOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 17:14:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:33735 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264184AbUFBVNS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 17:13:18 -0400
Date: Wed, 2 Jun 2004 14:13:13 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Arjan van de Ven <arjanv@redhat.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [announce] [patch] NX (No eXecute) support for x86, 2.6.7-rc2-bk2
In-Reply-To: <20040602205025.GA21555@elte.hu>
Message-ID: <Pine.LNX.4.58.0406021411030.3403@ppc970.osdl.org>
References: <20040602205025.GA21555@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 2 Jun 2004, Ingo Molnar wrote:
> 
> If the NX feature is supported by the CPU then the patched kernel turns
> on NX and it will enforce userspace executability constraints such as a
> no-exec stack and no-exec mmap and data areas. This means less chance
> for stack overflows and buffer-overflows to cause exploits.

Just out of interest - how many legacy apps are broken by this? I assume 
it's a non-zero number, but wouldn't mind to be happily surprised.

And do we have some way of on a per-process basis say "avoid NX because
this old version of Oracle/flash/whatever-binary-thing doesn't run with
it"?

		Linus
