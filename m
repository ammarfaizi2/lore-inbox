Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263431AbTJUVEv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 17:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263432AbTJUVEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 17:04:50 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:25860 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263431AbTJUVEs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 17:04:48 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Circular Convolution scheduler
Date: 21 Oct 2003 20:54:46 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bn46em$j0d$1@gatekeeper.tmr.com>
References: <bn3ur5$htf$1@gatekeeper.tmr.com> <Pine.LNX.4.53.0310211607110.19990@chaos>
X-Trace: gatekeeper.tmr.com 1066769686 19469 192.168.12.62 (21 Oct 2003 20:54:46 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.53.0310211607110.19990@chaos>,
Richard B. Johnson <root@chaos.analogic.com> wrote:
| On Tue, 21 Oct 2003, bill davidsen wrote:

| Isn't scheduling something that's supposed to
| be deterministic? I think your "nice marketing
| name that sounds very technical" scheduler would
| put policy in absolutely the wrong place.

Well the circular... is certainly not in any way mine, although I find
it interesting. I think that using policy to produce a deterministic
result is just what you get by tuning any scheduler, from Ingo, Con,
Nick, or anyone else. Putting the bias in the algorithm is another way
to do it, assuming that's what you meant.

| We need less heuristics in the kernel, not more.
| Already, we don't know anything about the time
| necessary to guarantee much of anything. This
| impacts data-base programs that are trying to
| find safe intervals, guaranteed to be restartable.
| 
| Also, the "circular convolution theorem", from
| which I would guess the name was scrounged, does
| not relate in any imaginable way to kernel scheduling.
| The name is a misnomer when used in this context.
| That theorem states simply that what can be done
| with a DFT can be undone using the same mechanism.

Don't expect me to defend it, not my idea. I hold that the next major
advance will come from having VM, elevator, and scheduler all sharing
hints, but I have no proposal on that, by any name.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
