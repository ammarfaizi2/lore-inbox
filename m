Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269040AbUJKO51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269040AbUJKO51 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 10:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269031AbUJKO4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 10:56:44 -0400
Received: from main.gmane.org ([80.91.229.2]:42668 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S269014AbUJKOxX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 10:53:23 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan Rychter <jan@rychter.com>
Subject: Re: 2.6.9-rc2-mm1 swsusp bug report.
Date: Mon, 11 Oct 2004 23:53:29 +0900
Message-ID: <m2hdp1gvbq.fsf@tnuctip.rychter.com>
References: <2HO0C-4xh-29@gated-at.bofh.it> <2I5b2-88s-15@gated-at.bofh.it>
	<2I5E5-6h-19@gated-at.bofh.it> <2I7Zd-1TK-11@gated-at.bofh.it>
	<E1CB10O-0000HL-FJ@localhost> <20040925101640.GB4039@elf.ucw.cz>
	<m2zn2uigka.fsf@tnuctip.rychter.com>
	<20041011133234.GA16217@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 66-27-68-14.san.rr.com
X-Spammers-Please: blackholeme@rychter.com
User-Agent: Gnus/5.110003 (No Gnus v0.3) XEmacs/21.4 (Security Through
	Obscurity, linux)
Cancel-Lock: sha1:VPR5EayQ8epi4ZzF9tkPzuB8NPE=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Pavel" == Pavel Machek <pavel@ucw.cz> writes:
 Pavel> Hi!  You do not know how much you should preallocate, because it
 Pavel> depends on ammount of memory used. You could preallocate maximum
 Pavel> possible ammount...
 >>
 Pavel> OTOH this is first report of this failure. If it fails once in a
 Pavel> blue moon, it is probably better to let it fail than waste
 Pavel> memory.
 >>
 >> This is *exactly* why I choose to use swsusp2. There is a marked
 >> difference in the maintainer's approach to these kinds of problems.

 Pavel> Okay, and do you have something to say or do you want to start
 Pavel> flamewar? That is also why swsusp2 is 10 times code size of
 Pavel> swsusp...

Sure, flame me if you think this is the right thing to do. But I will
continue to pitch in with a users' opinion sometimes, because I really
believe it is important.

It is easy to lose sight of the user perspective on these things if all
you deal with is kernel development. You probably reboot your machine
dozens of times a day anyway. However, for some users crashes and
reboots are *very* expensive. These people (myself included) consider
sprinkling the code with panics, crashing and failing an unacceptable
thing to do.

I also believe your reply shows how important it is for me to actually
write things like these from time to time (even risking getting
flamed). As a user I don't care whatsoever what the code size
is. Actually, I don't care that much about its performance, either. What
I do care about is that my operating system doesn't crash from under me,
doesn't lose my data, and doesn't fail on me with suspending when I
really need it to suspend now. Give me a userspace USB implementation
that works 10x slower and is 10x larger but doesn't crash my machine and
I'll take it any day.

--J.

