Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265907AbUBCIEN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 03:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265931AbUBCIEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 03:04:13 -0500
Received: from mx2.elte.hu ([157.181.151.9]:35240 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265907AbUBCIEK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 03:04:10 -0500
Date: Tue, 3 Feb 2004 09:04:36 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>,
       dipankar@in.ibm.com
Subject: Re: [PATCH 3/4] 2.6.2-rc2-mm2 CPU Hotplug: The Core
Message-ID: <20040203080436.GA374@elte.hu>
References: <20040202154040.GA5895@elte.hu> <20040203010224.2A2F52C0CB@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040203010224.2A2F52C0CB@lists.samba.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: SpamAssassin 2.60
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Rusty Russell <rusty@rustcorp.com.au> wrote:

> This terminating signal idea is simply flawed: affinity is inherited,
> so you're killing a process which knows nothing anyway.
> 
> If we can't do it well, leave it to userspace to sort out 8)

yes, but currently there's no mechanism for userspace to get notified -
hence no clean way for userspace to sort it out. (other than userspace
continuously polling the CPU mask - bleh.) But this is a separate issue.

	Ingo
