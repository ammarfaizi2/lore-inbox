Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264832AbTIIWKn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 18:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264833AbTIIWKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 18:10:43 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:9745 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264832AbTIIWKf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 18:10:35 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.0-test5: configcheck results
Date: 9 Sep 2003 22:01:43 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bjlik7$gla$1@gatekeeper.tmr.com>
References: <20030909100412.A25143@flint.arm.linux.org.uk>
X-Trace: gatekeeper.tmr.com 1063144903 17066 192.168.12.62 (9 Sep 2003 22:01:43 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030909100412.A25143@flint.arm.linux.org.uk>,
Russell King  <rmk@arm.linux.org.uk> wrote:

| I just ran make configcheck on 2.6.0-test5 and the results are:
| 
|     832 files need linux/config.h but don't actually include it.
|     689 files which include linux/config.h but don't require the header.

I'm suspicious of the first one, unless you mean "include it with
multi-level includes of other stuff." The second one is probably close
to the truth.

Thanks for doing this work, I'm not sure any tool is trustworthy, but it
should be relatively easy to test the "do not need" files with a script.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
