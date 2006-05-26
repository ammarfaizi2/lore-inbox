Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbWEZST3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWEZST3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 14:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWEZST3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 14:19:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30612 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751235AbWEZST3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 14:19:29 -0400
Message-ID: <4477469F.7040103@redhat.com>
Date: Fri, 26 May 2006 13:19:11 -0500
From: Clark Williams <williams@redhat.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Mark Knecht <markknecht@gmail.com>,
       Robert Crocombe <rwcrocombe@raytheon.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH -rt 0/2] Get x86_64 running with PREEMPT_RT
References: <20060526160651.870725515@goodmis.org>
In-Reply-To: <20060526160651.870725515@goodmis.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Steven Rostedt wrote:
> The following two patches get PREEMPT_RT running on x86_64.  I'm currently
> writing this from my x86_64 box running 2.6.16-rt23.
>
> The first patch probably only affected me, since it was caused by
> having clocksource=XXX in the command line.
>
> The other patch simply fixes a bad condition in the default_idle
> which prevented the idle task from ever scheduling (that was bad!)
Fixed my problem on Athlon64x2.

Thanks,
Clark
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEd0afHyuj/+TTEp0RAmMsAJ9Zf1n/GMHOB+SYXdI7fWGYfbkcVwCgrK6I
I0pV042x2vtPj7750lzIXeM=
=eMDn
-----END PGP SIGNATURE-----

