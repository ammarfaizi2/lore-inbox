Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbUCIQMU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 11:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbUCIQMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 11:12:20 -0500
Received: from mx2.elte.hu ([157.181.151.9]:21188 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262041AbUCIQJh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 11:09:37 -0500
Date: Tue, 9 Mar 2004 17:10:51 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in <=16G machines)
Message-ID: <20040309161051.GA11046@elte.hu>
References: <Pine.LNX.4.58.0403081238060.9575@ppc970.osdl.org> <20040308132305.3c35e90a.akpm@osdl.org> <20040308230247.GC12612@dualathlon.random> <20040308152126.54f4f681.akpm@osdl.org> <20040308234014.GG12612@dualathlon.random> <20040309083103.GB8021@elte.hu> <20040309090326.GA10039@elte.hu> <20040309145130.GC8193@dualathlon.random> <20040309150942.GA8224@elte.hu> <20040309152438.GE8193@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040309152438.GE8193@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner-4.26.8-itk2 SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrea Arcangeli <andrea@suse.de> wrote:

> > could you just try test-mmap2.c on such a box, and hit swap?

> Unless it crashes the machine I don't care, it's totally wrong in my
> opinion to hurt everything useful to save cpu while running an
> exploit. there are easier ways to waste cpu (rewrite the exploit with
> truncate please!!!)

i'm not sure i follow. "truncate being slow" is not the same order of
magnitude of a problem as "the VM being incapable of getting work done".

	Ingo
