Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbWE3T2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWE3T2W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 15:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbWE3T2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 15:28:22 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:49342 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932298AbWE3T2V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 15:28:21 -0400
Date: Tue, 30 May 2006 21:28:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm1
Message-ID: <20060530192838.GA22742@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org> <6bffcb0e0605300916l6e22c814jf9368856f33a9599@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0605300916l6e22c814jf9368856f33a9599@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:

> Hi Ingo,
> 
> On 30/05/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm1/
> >
> 
> Here is small lockdep bug
> 
> May 30 18:05:08 ltg01-fedora ainit:
> May 30 18:05:09 ltg01-fedora kernel: BUG: warning at
> /usr/src/linux-mm/kernel/lockdep.c:1853/trace_hardirqs_on()

hm. Do you have the NMI watchdog enabled? [does /proc/interrupts show 
any increasing NMI counts?]

	Ingo
