Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314507AbSDSAEx>; Thu, 18 Apr 2002 20:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314508AbSDSAEx>; Thu, 18 Apr 2002 20:04:53 -0400
Received: from paloma14.e0k.nbg-hannover.de ([62.181.130.14]:45822 "HELO
	paloma14.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S314507AbSDSAEw>; Thu, 18 Apr 2002 20:04:52 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Robert Love <rml@tech9.net>
Subject: Re: [PATCHSET] Linux 2.4.19-pre7-jam1
Date: Fri, 19 Apr 2002 02:04:48 +0200
X-Mailer: KMail [version 1.4]
Cc: "J.A. Magallon" <jamagallon@able.es>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@zip.com.au>, Ingo Molnar <mingo@redhat.com>,
        Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <200204190136.15978.Dieter.Nuetzel@hamburg.de> <1019173481.5395.149.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200204190204.48566.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 April 2002 01:44, Robert Love wrote:
> On Thu, 2002-04-18 at 19:36, Dieter Nützel wrote:
> > No uptodate O(1) patch for 2.4. Very sad.
> > So there isn't any change to see a current preemption patch on top of
> > vm33 and O(1).
>
> I am working on backports of all the O(1) scheduler changes in 2.5, the
> pending changes, and some other misc. bits.  I also have versions of the
> migration_thread and affinity stuff for 2.4.

Ahhh, I'm very happy to hear this. GREAT!!!

> I will release a general O(1) patch and a patch for -ac soon - hopefully
> tomorrow or Monday.  I have no idea if it fixes the problems you are
> seeing, because I have no idea what caused a regression in the O(1)
> code.

I couldn't figure it right, but I've rechecked simple 2.4.18 without all 
"pending stuff" and it shows the same numbers as 2.4.19-pre7+AA.

When I apply Ingo's originall sched-O1-2.4.18-pre8-K3.patch or J.A.'s the 
latency goes bad.

> > No, lowlatency didn't come close to preemption+lock-break (best latency
> > numbers for 2.4.17-preX-rml, were ~2.9ms max).
>
> Good to hear ;)
>
> > I'm under the impression that "all" development is focused on 2.5.x, now.
> > Even the VM stuff show no mayor growth ;-(
>
> That is the point of 2.5 :)

Yes, I know, it is more fun...;-)

> Development => !Stability and people need to start using 2.4 to get work
> done, not reap faster and faster benchmarks times.  I seriously suspect
> 2.4 is performing fine right now for what you are doing, anyhow.

Nope, it is my devel machine and I do "heavy" C++ VIS app and XFree86 DRI 
compiler runs in the background during browsing, mail, etc. --- "Normal" 
workstation use...;-)

My dual Athlon MP/XP is some days around the corner ;-(

> Also, a lot of VM work is happening in 2.4 (and not in 2.5 even, at the
> moment).  2.4.19-pre has seen a few of the -aa bits merged and should
> see most of the others in due time.
>
> There is also Rik's -rmap for 2.4 ...

Wouldn't start a VM flameware, again but -rmap didn't come close in VM 
throughput. 2.4.17-preX-aa-O(1)-rml was the killer.

Thank you for all your work!

-Dieter

BTW As always, send me copies, please ;-)
