Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266103AbTLIU7W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 15:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266107AbTLIU7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 15:59:21 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:20489 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S266103AbTLIU7T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 15:59:19 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Linux GPL and binary module exception clause?
Date: 9 Dec 2003 20:47:58 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <br5cdu$ngd$1@gatekeeper.tmr.com>
References: <200312091322.33506.andrew@walrond.org> <1070979148.16262.63.camel@oktoberfest>
X-Trace: gatekeeper.tmr.com 1071002878 24077 192.168.12.62 (9 Dec 2003 20:47:58 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1070979148.16262.63.camel@oktoberfest>,
Dale Whitchurch  <dalew@sealevel.com> wrote:
| A question for this thread:
| 
| Is the GPL in effect for the kernel so that anybody can enhance the
| current drivers and add support for any other device?  If two companies
| develop competing products and those products (albeit a few slight
| differences) perform the same operations using almost the same hardware,
| do we want one company to use the others driver? 

  If company A writes a driver which is not GPL it doesn't concern the
Open Source community. Not even if it's open source but proprietary.
Yes, dual license exists, I don't think that changes things here.

  If company A writes a GPL driver company B may modify it as long as
they release source.

  If company B offered the modified driver for kernel inclusion,
there's a high probability one of the penguins would tell them to fold
the changes into the original module and make it dual-purpose (unless
there were a LOT of changes).

  Company B could decline and ship the GPL driver with their hardware,
source and a binary loadable module included. Given the hassle factor I
bet they wouldn't. Nvadia must be really tired of getting every problem
related to a tainted kernel.

| In another sense, does the kernel evolve to reflect this?  If the
| overall driver acts the same minus a few hardware differences, does the
| kernel source change by abstracting the similarities and allow both
| companies to write the device specific code?  Does it instead say that
| both cards must have independent source code?  Or do we only allow the
| first driver into the source tree?

  Once GPL'd the choices are clear, it could be separate or added
functionality on a technical basis, no need for one policy to fit all.
| 
| There are no evil overtones in this email, nor any disgruntled developer
| feelings.  I am just reading at this thread and asking myself, "Is the
| overall goal for everyone to get along?"
| 
| Dale Whitchurch
| 
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
| 


-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
