Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284324AbRLBUof>; Sun, 2 Dec 2001 15:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284349AbRLBUnU>; Sun, 2 Dec 2001 15:43:20 -0500
Received: from zero.tech9.net ([209.61.188.187]:13324 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S284325AbRLBUls>;
	Sun, 2 Dec 2001 15:41:48 -0500
Subject: Re: average user comments on 2.5.1-pre5
From: Robert Love <rml@tech9.net>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0112021404290.14914-100000@netfinity.realnet.co.sz>
In-Reply-To: <Pine.LNX.4.33.0112021404290.14914-100000@netfinity.realnet.co.sz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 02 Dec 2001 15:41:35 -0500
Message-Id: <1007325697.9029.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-12-02 at 07:06, Zwane Mwaikambo wrote:

> 	I've just tried running 2.5.1-pre5 on my desktop machine and
> noticed the following, when untarring medium sized files (kernel tarballs)
> even from disk to disk (different channels) or moving large files around i
> get mouse lag in X and after its done, and the flushing to disk begins the
> interactive performance of the box takes a dive for the duration of that
> disk activity. The last kernel i had before this was 2.4.13-ac7-preempt
> which didn't exhibit this. 2.5.1-pre1 has the same problem.

Maybe you ought to try the preempt-kernel patch on your current kernel,
since it may of been responsible for your interactivity improvements.

Although I don't make explicit 2.5 patches available yet, the
2.4.17-pre1 or 2.4.16 patches should apply.  Conversely, 2.4.17-pre2 has
some changes that may improve latency.  You want to try it, or, even
better, it with the preemptive kernel patch.

The preempt-kernel patches can be found at:
	ftp://ftp.kernel.org/pub/linux/kernel/people/rml/preempt-kernel

	Robert Love

