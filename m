Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264156AbTKJWw3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 17:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264157AbTKJWw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 17:52:29 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:26628 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264156AbTKJWw1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 17:52:27 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: loopback device + crypto = crash on 2.6.0-test7 ?
Date: 10 Nov 2003 22:41:54 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bop47i$7eg$1@gatekeeper.tmr.com>
References: <1067411342.1574.11.camel@localhost> <20031109131018.GA18342@deneb.enyo.de>
X-Trace: gatekeeper.tmr.com 1068504114 7632 192.168.12.62 (10 Nov 2003 22:41:54 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031109131018.GA18342@deneb.enyo.de>,
Florian Weimer  <fw@deneb.enyo.de> wrote:
| Soeren Sonnenburg wrote:
| 
| > losetup -e blowfish /dev/loop0 /file
| > Password:
| > mkfs -t ext3 /dev/loop0
| > mount /dev/loop0 /mnt
| > <error unknown fs type>
| > <from here something was seriously broken... could not reboot anymore>
| 
| I'm seeing something similar, but in my case, mke2fs already crashes.
| 
| > system is:
| > Linux no 2.6.0-test7 #8 Sun Oct 26 17:00:49 CET 2003 ppc GNU/Linux
| 
| Mine ist -test9 on x86.
| 
| Have you found a solution in the meantime?

I have been using aes and not seeing this. I suppose it's unlikely that
there could be an error in the kernel crypto, but I think I'll wait and
try blowfish on a non-critical machine.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
