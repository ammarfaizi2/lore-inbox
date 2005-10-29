Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbVJ2ILF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbVJ2ILF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 04:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbVJ2ILE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 04:11:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48559 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751379AbVJ2ILC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 04:11:02 -0400
Date: Sat, 29 Oct 2005 01:09:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: bugme-daemon@kernel-bugs.osdl.org
Cc: morfic@gentoo.org, kraftb@kraftb.at, migo@abp.pl,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>
Subject: Re: [Bug 5039] high cpu usage (softirq takes 50% all the time)
Message-Id: <20051029010945.623a8dab.akpm@osdl.org>
In-Reply-To: <200510290754.j9T7sqAg027452@fire-1.osdl.org>
References: <200510290754.j9T7sqAg027452@fire-1.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bugme-daemon@kernel-bugs.osdl.org wrote:
>
> http://bugzilla.kernel.org/show_bug.cgi?id=5039
> 

Well this is a depressing saga.  A bunch of people whose machines appear to
be spending 50% CPU time in softirq processing.  Some find that `noapic'
fixes it and some dont.  Some are on x86_64, some are on x86.

I suspect we have multiple bugs here.  It's quite a mess.

Could the reporters please, via a reply-to-all to this email:

a) test 2.6.14.

b) summarise the current status of your bug (what CPU type, what are the
   symptoms, any known workarounds, etc).

c) Generate a kernel profile (see Documentation/basic_profiling.txt)

Generally, let's get a bit of action happening here and see if we can get
these relatively long-standing regressions fixed up, thanks.
