Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262318AbUKVVsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbUKVVsS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 16:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbUKVVmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 16:42:46 -0500
Received: from smtp.Lynuxworks.com ([207.21.185.24]:23820 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S262379AbUKVVbG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 16:31:06 -0500
Date: Mon, 22 Nov 2004 13:30:54 -0800
To: john cooper <john.cooper@timesys.com>
Cc: "Bill Huey (hui)" <bhuey@lnxw.com>, Esben Nielsen <simlo@phys.au.dk>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: Priority Inheritance Test (Real-Time Preemption)
Message-ID: <20041122213054.GB9058@nietzsche.lynx.com>
References: <Pine.OSF.4.05.10411212107240.29110-100000@da410.ifa.au.dk> <20041122092302.GA7210@nietzsche.lynx.com> <41A1F4B2.10401@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41A1F4B2.10401@timesys.com>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 09:16:18AM -0500, john cooper wrote:
> I'd hazard a guess the reason existing implementations do not
> do this type of dependency-chain closure is the complexity of a
> general approach.  Getting correct behavior and scaling on SMP
> require some restrictions of how lock ownership is maintained,
> otherwise fine grained locking is not possible.  Another likely

What do you mean by that ? Are you talking about strict priority
obedience by the system ?

> reason is the fact more mechanism is getting put in place for
> less likely inversion scenarios.  And when those scenarios do
> exist the cost of effecting promotion closure may well be
> greater than allowing the priority inversions to subside.
> However this point of diminishing returns is application
> dependent so there is no single, simple solution.

Yes, this is my point.

> That said I don't see anything in the current work which precludes
> doing any of the above.  To my eyes, the groundwork is already
> in place.

Yes it is. :)

bill

