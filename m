Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbTIHVuT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 17:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263593AbTIHVuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 17:50:19 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:32270 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263584AbTIHVuQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 17:50:16 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: BUG: in 2.6.0-test4-bk8 and bk9 involving handling of ethernet interfaces
Date: 8 Sep 2003 21:41:26 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bjit26$a3c$1@gatekeeper.tmr.com>
References: <3F5B87E2.6040501@open.org>
X-Trace: gatekeeper.tmr.com 1063057286 10348 192.168.12.62 (8 Sep 2003 21:41:26 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3F5B87E2.6040501@open.org>, Hal  <pshbro@open.org> wrote:
| When i was finishing up using a cross over cable to transfer data from 
| my desktop to my labtop I notied an odd thing. After I ifconfig eth0 
| down to close the interface on my desktop runing 2.6.0-test4-bk8 it 
| froze all my ttys and ptys. I upgraded to bk9 and got the same thing.
| 
| To repeat the bug one will need two computers and a cross over cable. 
| Connect the two computers, ifconfig the interfaces on each computer. 
| Give them both an ip and then ifconfig up them both. Now to get the bug 
| ifconfig the interface on the computer runing a 2.6 kernel down and 
| hopefully there will be a system freeze.
| 
| For more information im using a Net Gear fa311 ethernet NIC with the 
| Natsemi ethernet drivers.

Did you config as nodes on a whole network or use point-to-point config?
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
