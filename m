Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264566AbTLVX2o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 18:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264568AbTLVX2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 18:28:44 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:17675 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264566AbTLVX2m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 18:28:42 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: 2.6.0 modules don't link properly
Date: 22 Dec 2003 23:17:03 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bs7u1f$8ns$1@gatekeeper.tmr.com>
X-Trace: gatekeeper.tmr.com 1072135023 8956 192.168.12.62 (22 Dec 2003 23:17:03 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried building 2.6.0-final on a new whitebox-3.0-final install, and
the modules_install produced thousands of unresolved symbols. This built
on another machine I've been running and updating since the 2.5.3x days,
so there might be something I've missed, but I don't quite see what it
would be.

Whitebox is built from RH-ES-3.0 source, so the only things I updated
were the procps and modutils, using the last tar which didn't have "pre"
in the name. I see that there is a new tar, out nearly ten hours so it
must be stable, which has jumped from 0.9.15 to 3.0.15-pre1, but I'm
happily using something months old on other systems.

Can someone toss me a clue? Has anyone had a working build with
RH-ES-3.0? Yes, I know other things need to be done before I can
actually run the kernel, but being able to build would be nice, since I
got a new test system just for 2.6 test/demo use.


-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
