Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263963AbTJFDOv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 23:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263966AbTJFDOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 23:14:51 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:33029 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263963AbTJFDOt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 23:14:49 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Linux 2.6.0-test6
Date: 6 Oct 2003 03:05:14 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <blqm5a$dje$1@gatekeeper.tmr.com>
References: <&lt;3F7CBDD4.7010503@cyberone.com.au&gt;> <ddcbaa61f5ab6ec90c71a70bb3990b49@stdbev.com>
X-Trace: gatekeeper.tmr.com 1065409514 13934 192.168.12.62 (6 Oct 2003 03:05:14 GMT)
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

I would like to add my thoughts that test6-np15a is the winner for the
things I do. I can live with a sound skip (I haven't seen any, but it's
not my test app), I really want my typing to echo, to click on a header
in Kmail and see the text, to have ls works, etc. Nick has given me that
far more than test6 plain or with -mm flavor.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
