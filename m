Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbUCEOdk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 09:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262612AbUCEOdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 09:33:40 -0500
Received: from mx2.elte.hu ([157.181.151.9]:1689 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262610AbUCEOd2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 09:33:28 -0500
Date: Fri, 5 Mar 2004 15:34:25 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Peter Zaitsev <peter@mysql.com>, Andrew Morton <akpm@osdl.org>,
       riel@redhat.com, mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040305143425.GA11604@elte.hu>
References: <20040228072926.GR8834@dualathlon.random> <Pine.LNX.4.44.0402280950500.1747-100000@chimarrao.boston.redhat.com> <20040229014357.GW8834@dualathlon.random> <1078370073.3403.759.camel@abyss.local> <20040303193343.52226603.akpm@osdl.org> <1078371876.3403.810.camel@abyss.local> <20040305103308.GA5092@elte.hu> <20040305141504.GY4922@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040305141504.GY4922@dualathlon.random>
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

> > vsyscall-sys_gettimeofday and vsyscall-sys_time could help quite some
                                  ^^^^^^^^^^^^^^^^^
> > for mysql. Also, the highly threaded nature of mysql on the same MM
> 
> he said he doesn't use gettimeofday frequently, so most of the flushes
> are from other syscalls.

you are not reading Pete's and my emails too carefully, are you? Pete
said:

> [...] MySQL does not use gettimeofday very frequently now, actually it
> uses time() most of the time, as some platforms used to have huge
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> performance problems with gettimeofday() in the past.
>
> The amount of gettimeofday() use will increase dramatically in the
> future so it is good to know about this matter.

	Ingo
