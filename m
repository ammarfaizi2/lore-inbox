Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267634AbTGHUs4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 16:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267640AbTGHUsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 16:48:55 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:13977 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S267634AbTGHUsy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 16:48:54 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 8 Jul 2003 13:55:55 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Con Kolivas <kernel@kolivas.org>
cc: Szonyi Calin <sony@etc.utt.ro>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] O3int interactivity for 2.5.74-mm2
In-Reply-To: <200307090654.17408.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.55.0307081347310.4792@bigblue.dev.mcafeelabs.com>
References: <200307070317.11246.kernel@kolivas.org> <200307081759.39215.kernel@kolivas.org>
 <Pine.LNX.4.55.0307080806400.4544@bigblue.dev.mcafeelabs.com>
 <200307090654.17408.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jul 2003, Con Kolivas wrote:

> > the ratio between timeslices. If you have three processes running with
> > timeslices :
> >
> > A = 400
> > B = 200
> > C = 100
> >
> > the interactivity is the same of the one if you have :
> >
> > A = 100
> > B = 50
> > C = 25
> >
> > What changes is the maxiomum CPU blackout time that each task has to see
> > before re-emerging again from the expired array. In the first case in
> > "only" 700ms while in the first case is 175ms.
>
> and what happens to the throughput?

Nothing. You'll have more context switches in average but if you think
that the context switch time will be diluted in tenths on ms runs you'll
get nothing. I really don't like to talk w/out being backed up by numbers
but currently I am really overbooked with other tasks and I cannot follow
up this (even if I'd like to). I am currently working 12-14 hours/day on
average, and I am one of those unperfect machines that still needs 6-7
hours rest somewhere during the day :)
(but I'll do it later if Ingo does not return from Mars or if someone else
does not do it)



- Davide

