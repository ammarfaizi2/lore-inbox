Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbTKYRdl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 12:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbTKYRdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 12:33:41 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:40199 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262133AbTKYRdk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 12:33:40 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: What exactly are the issues with 2.6.0-test10 preempt?
Date: 25 Nov 2003 17:22:43 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bq0353$4m8$1@gatekeeper.tmr.com>
References: <Pine.LNX.4.58.0311241356420.1473@home.osdl.org> <20031124222652.16351.qmail@web40910.mail.yahoo.com> <yw1xhe0t8k4i.fsf@kth.se> <20031124225112.GA1343@mis-mike-wstn.matchmail.com>
X-Trace: gatekeeper.tmr.com 1069780963 4808 192.168.12.62 (25 Nov 2003 17:22:43 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031124225112.GA1343@mis-mike-wstn.matchmail.com>,
Mike Fedyk  <mfedyk@matchmail.com> wrote:
| On Mon, Nov 24, 2003 at 11:41:33PM +0100, M?ns Rullg?rd wrote:
| > I've been running 2.6.0-test10 for a few hours on my P4M Asus laptop.
| > Playing music, editing files, compiling some things, some web surfing,
| > no problems.  Nothing unusual reported by the kernel.
| 
| Now take your .config and compare it with someone who is getting problems
| with preempt, and others, and narrow it down.

Just a caution, I suspect that this is related to something happening in
a small time window, and identical configs might not work the same on
different machines. Interrupt timing can be changed by disk layout,
rotational speed of the drive, interrupt priority, maybe even a user
event like keystroke or mouse action.

Comparing configs will help, but may not be consistent.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
