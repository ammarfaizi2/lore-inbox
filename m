Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTKYAPG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 19:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbTKYAPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 19:15:06 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:7174 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261868AbTKYAPD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 19:15:03 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: hard links create local DoS vulnerability and security problems
Date: 25 Nov 2003 00:04:07 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bpu69n$a3$1@gatekeeper.tmr.com>
References: <200311241736.23824.jlell@JakobLell.de> <200311241857.41324.jlell@JakobLell.de> <200311241921.50001.mbuesch@freenet.de> <20031124105321.A16684@osdlab.pdx.osdl.net>
X-Trace: gatekeeper.tmr.com 1069718647 323 192.168.12.62 (25 Nov 2003 00:04:07 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031124105321.A16684@osdlab.pdx.osdl.net>,
Chris Wright  <chrisw@osdl.org> wrote:
| * Michael Buesch (mbuesch@freenet.de) wrote:
| > What about _not_ modifying the mainstream-kernel behaviour,
| > but adding an option, to make users unable to create such hard-links,
| > to selinux and/or grsec?
| 
| It's already in grsec and owl.  SELinux has the ability to control this
| behaviour, just requires the right policy.

Bah!! I just spent 20 minutes deciding that I could add an attribute to
a file which prevented hard links, and similar to a directory. OTOH you
saved me the work of doing more than a few lines on paper, and it's
reassuring to know the security patches are ahead of the problem.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
