Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267769AbUJEBXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267769AbUJEBXG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 21:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268700AbUJEBXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 21:23:06 -0400
Received: from smtp1.netcabo.pt ([212.113.174.28]:9490 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S267769AbUJEBWv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 21:22:51 -0400
Message-ID: <32786.192.168.1.5.1096939184.squirrel@192.168.1.5>
In-Reply-To: <20041004215315.GA17707@elte.hu>
References: <20040919122618.GA24982@elte.hu> <414F8CFB.3030901@cybsft.com>
    <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu>
    <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu>
    <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu>
    <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu>
    <20041004215315.GA17707@elte.hu>
Date: Tue, 5 Oct 2004 02:19:44 +0100 (WEST)
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm1-S9
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       "K.R. Foley" <kr@cybsft.com>, "thewade" <pdman@aproximation.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 05 Oct 2004 01:22:44.0571 (UTC) FILETIME=[D0E5EAB0:01C4AA79]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo wrote:
>
> i've released the -S9 VP patch:
> http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc3-mm2-S9
>

Me again, we bad humor :(

My SMP/HT box is (again) terribly in that uglyness of being quite
unfriendly to -mm1, -mm2, and indirectly to -S8 and -S9 labeled kernels.

It works quite well with vanilla 2.6.9-rc3, though.

But very, very bad with those -mm1 or -mm2 patches. To get it straight,
almost all the time it hangs, randomly, but not as completely as to a
dramatic cold-reboot. It stalls on the the most administrative tasks. Name
one, and it stalls! I can hardly feel lucky if it sometimes reaches the
login prompt, while boot/initing.

I know you remember this story. Yeah. This seems quite similar to some of
earlier problems, but (un/fortunately) it doesn't seem related to VP at
all. Just having -mm1 or -mm2 is enough to make this machine go astray.

However, as usual, this seems to be ix86 SMP/HT specific. On my laptop, I
get to run full 2.6.9-rc3-mm2-S9 UP very happily.

Sorry if I can't get any real or useful debug data for now. The bad
behavior I'm referring to, is terribly non-deterministic, so I couldn't
get a pattern yet.

I just wanted to let you know ;)

Sorry for the bandwidth waste,

Cheers,
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

