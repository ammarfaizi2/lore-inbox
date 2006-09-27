Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965163AbWI0W5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965163AbWI0W5P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 18:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965164AbWI0W5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 18:57:15 -0400
Received: from mail.suse.de ([195.135.220.2]:49377 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965163AbWI0W5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 18:57:14 -0400
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 0/5] Message signaled irq handling cleanups
Date: Thu, 28 Sep 2006 00:57:03 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Tony <tony.luck@intel.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <m18xk5m6fm.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m18xk5m6fm.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609280057.03372.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 September 2006 21:54, Eric W. Biederman wrote:
> 
> The following patch set should be enough to clear up the
> outstanding issues with genirq on i386 and x86_64.  This actually
> takes things a step farther and moves all of architecture
> dependencies I could find into the appropriate architecture.
> 
> So hopefully we are finally close enough that other architectures
> will be able implement msi support, without too much trouble.
> 
> msi: Simplify msi sanity checks by adding with generic irq code.
> msi: Only use a single irq_chip for msi interrupts
> msi: Refactor and move the msi irq_chip into the arch code.
> msi: Move the ia64 code into arch/ia64
> htirq: Tidy up the htirq code


The (small) x86-64 parts are fine by me. Thanks.

-Andi
