Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286962AbSANPrr>; Mon, 14 Jan 2002 10:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286949AbSANPrg>; Mon, 14 Jan 2002 10:47:36 -0500
Received: from mx2.elte.hu ([157.181.151.9]:56466 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S286962AbSANPr1>;
	Mon, 14 Jan 2002 10:47:27 -0500
Date: Mon, 14 Jan 2002 18:44:42 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: cross-cpu balancing with the new scheduler
In-Reply-To: <3C42FBA7.B1084B4D@colorfullife.com>
Message-ID: <Pine.LNX.4.33.0201141843090.8805-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(it turns out that Manfred used 2.5.2-pre11-vanilla for this test.)

On Mon, 14 Jan 2002, Manfred Spraul wrote:

> PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
>  1163 root      39  19   396  396   324 R N  99.5  0.1   0:28 eatcpu
>  1164 root      39  19   396  396   324 R N  33.1  0.1   0:11 eatcpu
>  1165 root      39   0   396  396   324 R    33.1  0.1   0:07 eatcpu
>  1166 root      39 -19   396  396   324 R <  31.3  0.1   0:06 eatcpu

The load-balancer in 2.5.2-pre11 is known-broken, please try the -H7 patch
to get the latest code.

	Ingo

