Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262365AbTJISyj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 14:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbTJISyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 14:54:39 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:38416 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262365AbTJISyi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 14:54:38 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Linux 2.6.0-test6
Date: 9 Oct 2003 18:44:56 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bm4ab8$5fi$1@gatekeeper.tmr.com>
References: <&lt;3F7CBDD4.7010503@cyberone.com.au&gt;> <ddcbaa61f5ab6ec90c71a70bb3990b49@stdbev.com>
X-Trace: gatekeeper.tmr.com 1065725096 5618 192.168.12.62 (9 Oct 2003 18:44:56 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <ddcbaa61f5ab6ec90c71a70bb3990b49@stdbev.com>,
Jason Munro <jason@stdbev.com> wrote:
| On October 2, 7:07 pm Nick Piggin <piggin@cyberone.com.au> wrote:
| >
| > Pedro Larroy wrote:
| >
| > > On Thu, Oct 02, 2003 at 01:05:36PM +1000, Nick Piggin wrote:
| > > I'm afraid this selection criteria leads to a scheduler that isn't
| > > predictable for situations that aren't the ones for which is tuned to
| > > work. Of course I may be wrong, but to me, seems that saying
| > > explicitly which tasks are interactive sounds better.
| > >
| >
| > Have a look at my scheduler if you like. It won't estimate interactivity
| > but it works quite well if you nice -10 your X server. Ie. explicitly
| > state which process should be favoured.
| > http://www.kerneltrap.org/~npiggin/v15a/
| 
| I don't know much about kernel internals but of the 2.5 and 2.6 kernels I
| have tried, 2.6.0-test6 is by far the best on the desktop for my use (xmms,
| vmware, firebird, loads of other apps). With this patch it's better still.
| Before patching simple things like ls or ps have an annoying slowness while
| under a moderate/heavy load. For the most part things are fine but after
| patching commands respond more quickly. This is the first time for me a
| 2.5+ kernel has been responsive enough to use on a daily basis.

I really like my "np15a" patch, but it doesn't seem to play well with
preempt in terms of performance. Stability is fine so far.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
