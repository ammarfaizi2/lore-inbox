Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750931AbVHQGxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbVHQGxN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 02:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbVHQGxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 02:53:13 -0400
Received: from mx1.elte.hu ([157.181.1.137]:16771 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S1750914AbVHQGxM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 02:53:12 -0400
Date: Wed, 17 Aug 2005 08:53:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: George Anzinger <george@mvista.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [patch] KGDB for Real-Time Preemption systems
Message-ID: <20050817065340.GA9148@elte.hu>
References: <20050811110051.GA20872@elte.hu> <43028A94.1050603@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43028A94.1050603@mvista.com>
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


* George Anzinger <george@mvista.com> wrote:

> I have put a version of KGDB for x86 RT kernels here:
> http://source.mvista.com/~ganzinger/
> 
> The common_kgdb_cfi_.... stuff creates debug records for entry.S and 
> friends so that you can "bt" through them.  Apply in this order: 
> Ingo's patch kgdb-ga-rt.patch common_kgdb_cfi_annotations.patch
> 
> This is, more or less, the same kgdb that is in Andrew's mm tree 
> changed to fix the RT issues.

great. For the time being i wont add it to the -RT tree (because KGDB is 
not destined for upstream merging it seems), but it sure is a useful 
development/debugging add-on.

	Ingo
