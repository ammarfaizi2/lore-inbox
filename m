Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbTIKVZv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 17:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbTIKVZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 17:25:51 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:1287 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261543AbTIKVZu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 17:25:50 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Linux 2.4.22-ac2
Date: 11 Sep 2003 21:16:55 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bjqoo7$tp5$1@gatekeeper.tmr.com>
References: <200309092334.h89NYxh18536@devserv.devel.redhat.com>
X-Trace: gatekeeper.tmr.com 1063315015 30501 192.168.12.62 (11 Sep 2003 21:16:55 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200309092334.h89NYxh18536@devserv.devel.redhat.com>,
Alan Cox  <alan@redhat.com> wrote:
| (No its not course start time quite yet..)
| 
| Various little fixups and tidying bits. Some of these probably want to
| get pushed on to Marcelo eventually - the small bits and the CMPCI update
| certainly.
| 
| Linux 2.4.22-ac2
| o	Taint on sii6512 module that someone 		(Arjan van de Ven)
| 	"accidentally" marked as GPL but is nonfree

I'm happy to say I haven't ever had to use a tainted kernel, but is this
clearly marked at config time? Should there be a USE_TAINTED_CODE
global, like the EXPERIMENTAL and BROKEN options?
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
