Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263276AbTJUT1d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 15:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263280AbTJUT1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 15:27:33 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:28435 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263276AbTJUT1b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 15:27:31 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [RFC] frandom - fast random generator module
Date: 21 Oct 2003 19:17:30 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bn40oa$i4q$1@gatekeeper.tmr.com>
References: <3F8E552B.3010507@users.sf.net> <3F8E58A9.20005@cyberone.com.au>
X-Trace: gatekeeper.tmr.com 1066763850 18586 192.168.12.62 (21 Oct 2003 19:17:30 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3F8E58A9.20005@cyberone.com.au>,
Nick Piggin  <piggin@cyberone.com.au> wrote:

| Without looking at the code, why should this be done in the kernel?

Because it's a generally useful function, /dev/random and /dev/urandom
are in the kernel, /dev/urandom is SLOW. And doing a userspace solution
is a bitch in shell scripts ;-)

Since bloat is being discussed in several threads, you may want to
propose that /dev/*random be config options in the "delete features for
size" section.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
