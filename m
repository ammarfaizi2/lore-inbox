Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270436AbTHBWci (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 18:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270438AbTHBWci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 18:32:38 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:24850 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S270436AbTHBWcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 18:32:36 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH] O11int for interactivity
Date: Sat, 2 Aug 2003 23:27:45 +0200
User-Agent: KMail/1.5.2
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200307301038.49869.kernel@kolivas.org> <20030731214314.GG15452@holomorphy.com> <200308011244.00670.m.c.p@wolk-project.de>
In-Reply-To: <200308011244.00670.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308022327.45282.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 August 2003 12:44, Marc-Christian Petersen wrote:

Hi William,

> > Could you make sure that you're not using 1A? (vanilla 1 and 1B are
> > both fine for these purposes).
> > Also, can I get a before/after of the following during an mp3 skip test?
> > vmstat 1 | tee -a vmstat.log
> > n=1; while true; do /usr/sbin/readprofile -n -m /boot/System.map-`uname
> > -r`
> > | sort -k 2,2 > profile.log.$n; n=$(( $n + 1 )); sleep 1; done
> > If you could stop the logging shortly after the skip in the kernel that
> > does skip (but not _too_ shortly after, give it at least 1 second) I
> > would be much obliged. The "before" picture is most important. An
> > "after" picture might also be helpful, but isn't strictly necessary.
> Sure, I'll test it this weekend (mostly tomorrow). Stay tuned.
> Thanks for your interest in fixing this.

Sorry, I was busy till now. Ok, now I have time. Well, but reading your mail 
again, you are interested in vmstat 1 if an mp3 skip occurs. I have to say, 
that I never ever got an mp3 skip with your tree (-wli1 I am using).

and now? :)

ciao, Marc


