Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265362AbUAPKra (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 05:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265366AbUAPKra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 05:47:30 -0500
Received: from gprs214-224.eurotel.cz ([160.218.214.224]:18816 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265362AbUAPKr2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 05:47:28 -0500
Date: Fri, 16 Jan 2004 11:47:18 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: rml@ximian.com, linux-kernel@vger.kernel.org
Subject: Re: Laptops & CPU frequency
Message-ID: <20040116104718.GA10217@elf.ucw.cz>
References: <20040111025623.GA19890@ncsu.edu> <20040111025623.GA19890@ncsu.edu> <1073791061.1663.77.camel@localhost> <E1Afj2b-0004QN-00@chiark.greenend.org.uk> <E1Afj2b-0004QN-00@chiark.greenend.org.uk> <1073841200.1153.0.camel@localhost> <E1AfjdT-0008OH-00@chiark.greenend.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1AfjdT-0008OH-00@chiark.greenend.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >No - if the laptop changes speed on its own, using a system that Linux
> >does not understand, then Linux won't know about the change,
> >/proc/cpuinfo will not be updated, and stuff won't go too good.
> 
> Is there any realistic way of noticing this sort of change?

You can detect that tsc runs at wrong speed from timer interrupt.

								pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
