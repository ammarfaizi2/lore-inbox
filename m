Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVCaJdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVCaJdF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 04:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVCaJaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 04:30:14 -0500
Received: from mx2.elte.hu ([157.181.151.9]:35467 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261228AbVCaJQc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 04:16:32 -0500
Date: Thu, 31 Mar 2005 11:16:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Frank Rowand <frowand@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] ppc RT: Realtime preempt support for PPC
Message-ID: <20050331091614.GB22397@elte.hu>
References: <422CCC1D.1050902@mvista.com> <20050316100914.GA16012@elte.hu> <423F691E.200@mvista.com> <424B542F.9090308@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424B542F.9090308@mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Frank Rowand <frowand@mvista.com> wrote:

> < more stuff deleted >
> 
> I'm working on the architecture support for realtime on PPC64 now. If 
> the lock field of struct raw_rwlock_t is a long instead of int then 
> /proc/meminfo shows MemFree decreasing from 485608 kB to 485352 kB.
> 
> Do you have a preference for lock to be long instead of int?
> 
> Do you know if any of the other 64 bit architectures would have an 
> issue with int?

that would be nice to know. I have no preference, other than if possible 
it should be unified, no #ifdefs or other conditionals.

	Ingo
