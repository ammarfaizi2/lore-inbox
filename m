Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286462AbSAMSI6>; Sun, 13 Jan 2002 13:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287332AbSAMSIs>; Sun, 13 Jan 2002 13:08:48 -0500
Received: from zero.tech9.net ([209.61.188.187]:55313 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S286462AbSAMSIk>;
	Sun, 13 Jan 2002 13:08:40 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
From: Robert Love <rml@tech9.net>
To: jogi@planetzork.ping.de
Cc: yodaiken@fsmlabs.com, Andrea Arcangeli <andrea@suse.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, nigel@nrg.org,
        Rob Landley <landley@trommello.org>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020113161823.B1439@planetzork.spacenet>
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu>
	<1010781207.819.27.camel@phantasy>
	<20020112121315.B1482@inspiron.school.suse.de>
	<20020112160714.A10847@planetzork.spacenet>
	<20020112095209.A5735@hq.fsmlabs.com> 
	<20020113161823.B1439@planetzork.spacenet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 13 Jan 2002 13:11:21 -0500
Message-Id: <1010945482.11848.2.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-01-13 at 10:18, jogi@planetzork.ping.de wrote:

> No, I use a script which is run in single user mode after a reboot. So
> there are only a few processes running when I start the script (see
> attachment) and the jobs should start from the same environment.
> 
> > What happens when you do the same test, compiling one kernel under multiple
> > different kernels?
> 
> That is exactly what I am doing. I even try to my best to have the exact
> same starting environment ...

So there you go, his testing is accurate.  Now we have results that
preempt works and is best and it is still refuted.  Everyone is running
around with these "ll is best" or "preempt sucks throughput" and that is
not true.  Further, with preempt we can improve things cleanly, and I
don't think that necessarily implies priority inversion problems.

	Robert Love

