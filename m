Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264039AbTKMLsf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 06:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264040AbTKMLsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 06:48:35 -0500
Received: from webhosting.rdsbv.ro ([213.157.185.164]:16023 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S264039AbTKMLsd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 06:48:33 -0500
Date: Thu, 13 Nov 2003 13:48:28 +0200 (EET)
From: Catalin BOIE <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: Nick Piggin <piggin@cyberone.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0test9 + 2 * P IV Xeon 2.4GHz with HT + SATA + RAID1 =
 scheduler problems
In-Reply-To: <3FB36E18.2030105@cyberone.com.au>
Message-ID: <Pine.LNX.4.58.0311131345140.4183@hosting.rdsbv.ro>
References: <Pine.LNX.4.58.0311131303500.4183@hosting.rdsbv.ro>
 <3FB36E18.2030105@cyberone.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
Hi!

> Please capture a Ctrl + Scroll Lock dump when you get processes stuck in
> D state.
I will.

> >Also I suspect that scheduler doesn't pay special attention to virtual
> >(HT) processors. Is this true?
> >
>
> This is correct. Are you seeing any problems with HT? I think Linus

Do you think that disabling HT (how I do it? noht?) will make things works
better? I suspect that a process is scheduled on a virtual processor that
doesn't get much chances to execute something. I don't know.

> was hoping the NUMA / SMP scheduler could be generalised a bit more
> so that HT would just fall into place. This might not happen before
> 2.7, so the shared runqueue approach might be the next best thing
> (I like it).

The problem with HT is the one that I describe here. From time to time a
process (mc, bash) is stuck for 2-6 seconds and then comes back. In test8
this was more visible.

Thank you very much, Nick!

---
Catalin(ux) BOIE
catab@deuroconsult.ro
