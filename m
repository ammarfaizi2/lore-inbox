Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031146AbWKPJRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031146AbWKPJRx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 04:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031147AbWKPJRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 04:17:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45209 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1031146AbWKPJRw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 04:17:52 -0500
Date: Thu, 16 Nov 2006 01:17:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch, -rc6] x86_64: UP build fixes
Message-Id: <20061116011733.e119eae5.akpm@osdl.org>
In-Reply-To: <200611161001.01407.ak@suse.de>
References: <20061116084855.GA8848@elte.hu>
	<200611161001.01407.ak@suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2006 10:01:01 +0100
Andi Kleen <ak@suse.de> wrote:

> +#ifdef CONFIG_HOTPLUG_CPU
>  	hotcpu_notifier(cpu_vsyscall_notifier, 0);
> +#endif

this part isn't needed - the definition handles that.
