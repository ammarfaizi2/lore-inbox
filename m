Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314500AbSDRXol>; Thu, 18 Apr 2002 19:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314501AbSDRXok>; Thu, 18 Apr 2002 19:44:40 -0400
Received: from zero.tech9.net ([209.61.188.187]:34828 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S314500AbSDRXok> convert rfc822-to-8bit;
	Thu, 18 Apr 2002 19:44:40 -0400
Subject: Re: [PATCHSET] Linux 2.4.19-pre7-jam1
From: Robert Love <rml@tech9.net>
To: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: "J.A. Magallon" <jamagallon@able.es>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@zip.com.au>, Ingo Molnar <mingo@redhat.com>,
        Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <200204190136.15978.Dieter.Nuetzel@hamburg.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.3 
Date: 18 Apr 2002 19:44:41 -0400
Message-Id: <1019173481.5395.149.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-04-18 at 19:36, Dieter Nützel wrote:

> No uptodate O(1) patch for 2.4. Very sad.
> So there isn't any change to see a current preemption patch on top of vm33 
> and O(1).

I am working on backports of all the O(1) scheduler changes in 2.5, the
pending changes, and some other misc. bits.  I also have versions of the
migration_thread and affinity stuff for 2.4.

I will release a general O(1) patch and a patch for -ac soon - hopefully
tomorrow or Monday.  I have no idea if it fixes the problems you are
seeing, because I have no idea what caused a regression in the O(1)
code.

> No, lowlatency didn't come close to preemption+lock-break (best latency 
> numbers for 2.4.17-preX-rml, were ~2.9ms max).

Good to hear ;)

> I'm under the impression that "all" development is focused on 2.5.x, now.
> Even the VM stuff show no mayor growth ;-(

That is the point of 2.5 :)

Development => !Stability and people need to start using 2.4 to get work
done, not reap faster and faster benchmarks times.  I seriously suspect
2.4 is performing fine right now for what you are doing, anyhow.

Also, a lot of VM work is happening in 2.4 (and not in 2.5 even, at the
moment).  2.4.19-pre has seen a few of the -aa bits merged and should
see most of the others in due time.

There is also Rik's -rmap for 2.4 ...

	Robert Love

