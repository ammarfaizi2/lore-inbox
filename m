Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271371AbTGWWqc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 18:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271377AbTGWWqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 18:46:31 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:43272 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S271371AbTGWWqE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 18:46:04 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Make menuconfig broken
Date: 23 Jul 2003 22:53:39 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bfn3lj$lpe$1@gatekeeper.tmr.com>
References: <3F1D91F0.2020900@rackable.com> <Pine.LNX.4.44.0307222129070.17797-100000@phoenix.infradead.org>
X-Trace: gatekeeper.tmr.com 1059000819 22318 192.168.12.62 (23 Jul 2003 22:53:39 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0307222129070.17797-100000@phoenix.infradead.org>,
James Simmons  <jsimmons@infradead.org> wrote:
| 
| >   Well there are 2 issues here:
| > 
| > 1) How to handle "make oldconfig" on 2.4 config files.  Which may not be 
| > fixable in a manner that doesn't involve really ugly code.
| > 
| > 2) That make menuconfig|xconfig on a clean 2.6 tree results in a kernel 
| > that doesn't have console support.   This will be something that will 
| > come up over and over again in the future, and does not require ugly 
| > hacks to fix.
| 
| Instead of hacking up a oldconfig why not have the system detect old 
| config files and refuse to build it and tell the user to start from 
| scratch. I think this is acceptable.

I would say defconfig first, then menuconfig, but whatever. If you can't
do it right, don't do it at all. The problems introduced by almost-right
conversions are often harder to find than starting from default.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
