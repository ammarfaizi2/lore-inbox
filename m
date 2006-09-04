Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965014AbWIDW2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965014AbWIDW2f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 18:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWIDW2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 18:28:35 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:26499 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932148AbWIDW2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 18:28:34 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: Andi Kleen <ak@suse.de>
Cc: Dmitry Torokhov <dtor@insightbb.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH-mm] i8042: activate panic blink only in X
Date: Tue, 05 Sep 2006 08:29:09 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <ri9pf258l1q51kgsjs4u90sjp9581djjgs@4ax.com>
References: <200609022320.36754.dtor@insightbb.com> <p738xkz65ly.fsf@verdi.suse.de>
In-Reply-To: <p738xkz65ly.fsf@verdi.suse.de>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04 Sep 2006 16:58:33 +0200, Andi Kleen <ak@suse.de> wrote:

>Dmitry Torokhov <dtor@insightbb.com> writes:
>
>> Hi,
>> 
>> Here is an attempt to make panicblink only active in X so there is a
>> chance of keyboard still working after panic in text console. Any reason
>> why is should not be done this way?
>> 
>
>Looks good to me.
>
>Of course it would be even better to fix the panic stuff to not disrupt scrollback,
>but short of that it's a good idea.
>
>-Andi (original panic blink author)

I'd like to have panic blink and also be able to Shft-Up to previous 
console screens.  

If possible, kill the console blank timer too?  (dunno if you have).

Example: Oops screen on 2.4 recently I paged up to where the fault 
started, the screen blanker kicked in while I was hand copying info 
and wiped previous screens :(  Caused significant delay in working 
out what the issue was (slackware-10.2 2.4.33.1 glibc nptl boo-boo).

Is it safe / easy to do on oops/panic?

Grant.
