Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbTLPVGc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 16:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbTLPVGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 16:06:32 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:13323 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262446AbTLPVGa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 16:06:30 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 2.6 and IDE "geometry"
Date: 16 Dec 2003 20:55:01 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <brnrf5$1e3$1@gatekeeper.tmr.com>
References: <20031212131704.A26577@animx.eu.org> <20031214144046.GA11870@win.tue.nl> <20031214112728.A8201@animx.eu.org> <20031214202741.GA11909@win.tue.nl>
X-Trace: gatekeeper.tmr.com 1071608101 1475 192.168.12.62 (16 Dec 2003 20:55:01 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031214202741.GA11909@win.tue.nl>,
Andries Brouwer  <aebr@win.tue.nl> wrote:
| On Sun, Dec 14, 2003 at 11:27:28AM -0500, Wakko Warner wrote:
| 
| > > Or does it suffice to take */255/63 always?
| > 
| > I would say most cases use the 255/63
| 
| Good. So you can try constant geometry setting with *fdisk.
| 
| > with drives >4gb.  Is there anyway to query the bios to ask it?
| 
| Yes, and that is what the kernel used to do.
| In general, however, the answer is unreliable. 

Unless I misread his question, he didn't ask how to make it reliable,
he just wants the partitioning software to use it. Not to use something
he provides by hand, to ask the BIOS and use the numbers, right or
wrong.

With old BIOS versions I will agree that using any other geometry, no
matter how correct or reliable, will result in a failure to boot.

I wish I had an answer to the original question, but I don't. Fdisk
tries to intuit what partition info if there is at least one partition
already created, if that's the partitioning software you are already
using, I can't offer any other help.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
