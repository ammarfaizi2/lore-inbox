Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbUFCJGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbUFCJGl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 05:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbUFCJGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 05:06:41 -0400
Received: from mx2.elte.hu ([157.181.151.9]:46521 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261680AbUFCJGk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 05:06:40 -0400
Date: Thu, 3 Jun 2004 11:07:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [announce] [patch] NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Message-ID: <20040603090750.GA17049@elte.hu>
References: <20040602205025.GA21555@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040602205025.GA21555@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


here's the latest NX patch:

      http://redhat.com/~mingo/nx-patches/nx-2.6.7-rc2-bk2-AF

Changes since -AE:

 - use vmalloc_exec() in module_alloc() (bug noticed by Rusty Russell)

 - unexport vmalloc_exec() (suggested by Christoph Hellwig)

 - fix compilation warning when !PAE (Andrew Morton)

	Ingo
