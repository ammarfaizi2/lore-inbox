Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbTHST2S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 15:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbTHST2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 15:28:05 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:59665 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261230AbTHST1N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 15:27:13 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: scheduler interactivity: timeslice calculation seem wrong
Date: 19 Aug 2003 19:18:59 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bhtt73$8i4$1@gatekeeper.tmr.com>
References: <3F41B43D.6000706@cyberone.com.au> <1061276043.6974.33.camel@orbiter>
X-Trace: gatekeeper.tmr.com 1061320739 8772 192.168.12.62 (19 Aug 2003 19:18:59 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1061276043.6974.33.camel@orbiter>,
Eric St-Laurent  <ericstl34@sympatico.ca> wrote:

| Well, i was looking at TimeSys scheduler, trying something like that in
| 2.6 requires modifications to many files and it's a PITA to maintain a
| diff with frequents kernel releases. having a structure in place to
| plug-in other schedulers sure helps.

I agree. In fact I'm pretty sure I said something similar a while ago.
Unlike you I didn't do any major changes, certainly none I felt were of
general interest.

This could go in 2.7, though, or possibly in 2.6.x depending on how the
powers that be feel. I think having the scheduler as a plugin is a win
in terms of having whole special-use algorithms. It would have to be
done *very* carefully to be sure it didn't add measurable overhead.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
