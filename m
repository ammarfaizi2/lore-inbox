Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278207AbRJWUEK>; Tue, 23 Oct 2001 16:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278209AbRJWUEB>; Tue, 23 Oct 2001 16:04:01 -0400
Received: from newssvr17-ext.news.prodigy.com ([207.115.63.157]:10202 "EHLO
	newssvr17.news.prodigy.com") by vger.kernel.org with ESMTP
	id <S278207AbRJWUDs>; Tue, 23 Oct 2001 16:03:48 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
Newsgroups: linux.dev.kernel
Subject: Re: VM
In-Reply-To: <20011023002702.A2446@localhost>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: davidsen@deathstar.prodigy.com (Bill Davidsen)
Message-ID: <63kB7.3873$0w5.657641665@newssvr17.news.prodigy.com>
NNTP-Posting-Host: 192.168.192.240
X-Complaints-To: abuse@prodigy.net
X-Trace: newssvr17.news.prodigy.com 1003867458 000 192.168.192.240 (Tue, 23 Oct 2001 16:04:18 EDT)
NNTP-Posting-Date: Tue, 23 Oct 2001 16:04:18 EDT
Date: Tue, 23 Oct 2001 20:04:18 GMT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011023002702.A2446@localhost>,
Patrick McFarland <unknown@panax.com> wrote:
| Slightly off topic, but I kinda find it cool that this thread is still going, seeing as I
| started it on the 15th. =)
| 
| Anyhow, have we decided that 2.5 should have the ac-vm or the linus-vm?

I hope not, the bug-fix and corner case competition is doing good thing
for VM in both directions. That's healthy.

What I would like to see is VM moved to a module so you could have
either, or any of several competing designs which would be bound to
emerge once there's a neat interface and you can write to that instead
of trying to understand and hack all the stuff needed now. The effort is
high and the chance for problems high as well right now, in other words
a high ratio of implementation to method expertise.

I also would love to see the dispatcher moved to a module, so people can
easily play with ideas like the idle process, integrating VM and
dispatch operation at high memory load, etc.

Right now you not only need to understand the topic, but the
implementation. The implementation could be made easier with a clean
interface and an easy way to load changes for test without compiling a
kernel.

<BOOM>
  Yes, I'm still beating the drum for those modules.
</BOOM>

-- 
bill davidsen <davidsen@tmr.com>
  His first management concern is not solving the problem, but covering
his ass. If he lived in the middle ages he'd wear his codpiece backward.
