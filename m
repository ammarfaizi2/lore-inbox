Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262980AbTI2WBp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 18:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262983AbTI2WBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 18:01:45 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:54289 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262980AbTI2WBo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 18:01:44 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: PROBLEM: kernel 2.6-test5 rmmod: kernel NULL pointer dereference
Date: 29 Sep 2003 21:52:16 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bla9ig$483$1@gatekeeper.tmr.com>
References: <35776.10.0.0.50.1064747073.squirrel@mail.hackaholic.org>
X-Trace: gatekeeper.tmr.com 1064872336 4355 192.168.12.62 (29 Sep 2003 21:52:16 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <35776.10.0.0.50.1064747073.squirrel@mail.hackaholic.org>,
detach <detach@hackaholic.org> wrote:
| Hello,
| 
| I hope I'm using the right method to reporting this problem, I'll send it
| to the mailing list as this problem seems to be an overall kernel problem.
| No flames please :).
| Here's what happened,
| I wrote a CD so I did a modprobe ide-scsi .. then wrote the CD, now I
| wanted to check the contents of the CD, so i did rmmod ide-scsi first so
| that i could load ide-cd. Well, rmmod hung, and I checked /proc/kern.log
| on debian woody (with custom compiled linux 2.6-test5).Here's the output in /proc/kern.log:

Do you find there is any difference between the ide-cd operation and the
ide-scsi behaviour mounting /dev/scd0 (or sr0 depending on
distribution)? Redhat just uses the SCSI version, and I use SCSI on
Slackware as well most of the time (ie. when I have a burner).

It's good that you have reported a bug, but you may not need to go
through that path at all. As noted, supposedly fixed, although I haven't
built test6 yet.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
