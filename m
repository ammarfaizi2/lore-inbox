Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbULUJMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbULUJMT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 04:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbULUJMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 04:12:19 -0500
Received: from newmail.tauceti.org.au ([203.32.61.25]:32775 "EHLO
	tauceti.org.au") by vger.kernel.org with ESMTP id S261432AbULUJMN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 04:12:13 -0500
Subject: Re: [2.6 patch] ieee1394_core.c: remove unneeded EXPORT_SYMBOL's
From: Bernard Leach <leachbj@bouncycastle.org>
To: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: girish wadhwani <girish.wadh@gmail.com>, Lee Revell <rlrevell@joe-job.com>,
       Adrian Bunk <bunk@stusta.de>, bcollins@debian.org,
       Arne Caspari <arnem@informatik.uni-bremen.de>
In-Reply-To: <41C7E0D4.6010207@informatik.uni-bremen.de>
References: <20041220015320.GO21288@stusta.de>
	 <41C694E0.8010609@informatik.uni-bremen.de>
	 <20041220175156.GW21288@stusta.de>
	 <1103576759.1252.93.camel@krustophenia.net>
	 <e2e1047f04122013493f5b0151@mail.gmail.com>
	 <41C7E0D4.6010207@informatik.uni-bremen.de>
Content-Type: text/plain
Date: Tue, 21 Dec 2004 10:06:10 +0100
Message-Id: <1103619970.8788.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
X-Server: High Performance Mail Server - http://surgemail.com
X-Authenticated-User: leachbj@bouncycastle.org 
X-IP-stats: Notspam Incoming Last 0, First 0, in=3, out=0, spam=0 Known=true
X-External-IP: 217.234.191.168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The basis for removal of these exports was an alledged policy that
states unless there is at least one known opensource (GPL?) driver that
uses them they should not exist.  (I hope that paraphrase captured the
essence of the previous statements).

If this policy is as stated then its clearly short sighted.  If the
kernel is simply (the kernel and) the set of interfaces that support the
_existing_ drivers then that is all it will ever be.  I'm not saying
that is impossible for a driver writer to construct new interfaces that
their driver will require but I would suggest that in most cases this is
an unreasonable requirement.

APIs are a mechanism to export functionality from a particular
black-box, does it make sense that the constructor of that black-box
defines this API or some poor sod who has been given that black box on a
Friday afternoon and asked to deliver a driver on Monday?

Anyhow I think Ben has made it quite clear that this API exists for a
reason.

My point would be that waving some arbitrary policy around like the holy
grail does nothing to build a better kernel.

cheers,
bern.


