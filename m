Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbTHYRhx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 13:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbTHYRhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 13:37:53 -0400
Received: from dyn-ctb-210-9-243-188.webone.com.au ([210.9.243.188]:8964 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262038AbTHYRhv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 13:37:51 -0400
Message-ID: <3F4A496B.1030205@cyberone.com.au>
Date: Tue, 26 Aug 2003 03:37:47 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] renicing X
References: <3F4A3293.8070004@cyberone.com.au> <1061831528.2967.7.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1061831528.2967.7.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Felipe Alfaro Solana wrote:

>On Mon, 2003-08-25 at 18:00, Nick Piggin wrote:
>
>>My scheduler patch really benefits a lot from renicing X. I
>>think its because it nices more nicely. Any reasons why this
>>might be a bad idea?
>>

Hi Felipe,
Sorry I can't mail you directly. Some spam filter doesn't like me.

>
>Well, not for me... Although renicing X with Con patches makes X feel
>horrible, with your patches is not as horrible. However, I feel X much
>smoother with X reniced at +0. Renicing X at -20, for example, may
>reduce mouse cursor jumpiness under load, but makes X feel a little
>jerky in general (window movement is not as smooth as with X niced at
>+0). This is, however, based on subjective testing, not actual numbers.
>

Hmm interesting. Might be a bug...

>
>But for interactivity, most of the time it's the subjective feeling of
>the user about the system what matters, not numbers.
>

Yep

>
>And now we're talking about sched-policy-7a: under heavy load, spawning
>new processes still takes twice the time it takes when the system is
>under no load. For example, spawning a new Konsole session (not a new
>Konsole process, but a new session tab inside Konsole) takes approx. 1
>second on my P3-700Mhz. However, with sched-policy-7a and under heavy
>load (the mad while true; do a=2; done loop), it takes more than 2
>seconds.
>

OK thanks. I'll try to work on this.

>
>In general, sched-policy-7a feels extremely smooth and responsive in
>general but, for me, Con patches offer the smoothest X experience I have
>ever felt until date. Anyways, I will keep testing your patches and I
>greatly encourage you to keep improving them. It's always good to have
>diversity :-)
>

Well thats good. Thanks very much.

