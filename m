Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbWE3KMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWE3KMP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 06:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWE3KMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 06:12:15 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:41126 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932225AbWE3KMN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 06:12:13 -0400
Date: Tue, 30 May 2006 12:12:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm1
Message-ID: <20060530101236.GD31982@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530022925.8a67b613.akpm@osdl.org>
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


* Andrew Morton <akpm@osdl.org> wrote:

> - The build is broken on ia64 and probably on everything apart from 
>   x86, x86_64 and powerpc.  Check out the hot-fixes directory, as it 
>   won't be broken for long.

with the following patches i just sent:

 patches/genirq-ia64-build-fix.patch
 patches/irqtrace-support-nonx86.patch
 patches/lockdep-rwsem-fix.patch

ia64 defconfig builds fine now. I'd expect other non-x86 architectures 
to build fine too (with the lock validator disabled).

	Ingo
