Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262868AbUCPFzO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 00:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262893AbUCPFzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 00:55:13 -0500
Received: from mail-02.iinet.net.au ([203.59.3.34]:39076 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262868AbUCPFzC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 00:55:02 -0500
Message-ID: <405696A9.3060304@cyberone.com.au>
Date: Tue, 16 Mar 2004 16:54:49 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Kurt Garloff <garloff@suse.de>
CC: Con Kolivas <kernel@kolivas.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: bonus inheritance
References: <20040315225459.GY4452@tpkurt.garloff.de>
In-Reply-To: <20040315225459.GY4452@tpkurt.garloff.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Kurt Garloff wrote:

>
>The patch was written with the goal to improve interactive behaviour.
>It did achieve this. Processes freshly started had a higher bonus thatn
>the background kernel compile processes and thus get woken up.
>
>

Hi Kurt,
I'm sorry I can't comment too much on your patch, as I am not
too familiar with 2.6's scheduler policy. Never hurts to have
another pair of eyes looking at it though.

Does it help any actual interactivity problem? Unfortunately
practically any you make to the scheduler is bound to make
things worse for at least one person, so it is difficult to
just test things out.

Maybe we could include a compile (or even boot) time selectable
schedulers to test improvements. Or wait for 2.7 and backport
good bits. These two options still have the problem that most
of the users that matter still won't test them...

That said, if you have any real, reproducable problems that it
solves, you far improve your chances of it being picked up (in
one form or another).

Nick

