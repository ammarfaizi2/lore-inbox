Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751596AbWFQDcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbWFQDcq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 23:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751594AbWFQDcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 23:32:46 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:23812 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S1751236AbWFQDcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 23:32:46 -0400
Date: Sat, 17 Jun 2006 11:32:24 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: AGPGART: unable to get memory for graphics translation table.
Message-ID: <Pine.LNX.4.64.0606171125390.2748@raven.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-themaw-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0,
	required 5, autolearn=not spam)
X-themaw-MailScanner-From: raven@themaw.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I've been having trouble with my Radeon card not working with X.

01:00.0 VGA compatible controller: ATI Technologies Inc RV350 AS [Radeon 
9550]

The only thing I can find that may be a clue is:

Jun 17 11:12:48 raven kernel: agpgart: Detected AGP bridge 0
Jun 17 11:12:48 raven kernel: agpgart: unable to get memory for graphics 
translation table.
Jun 17 11:12:48 raven kernel: agpgart: agp_backend_initialize() failed.
Jun 17 11:12:48 raven kernel: agpgart-amd64: probe of 0000:00:00.0 failed 
with error -12

in the messages file.

I've seen this on a number of 2.6.17-rc kernels and just now on FC6 kernel 
2.6.16-1..2289_FC6 which, from the changelog is quite recent:

* Thu Jun 15 2006 Dave Jones <davej@redhat.com>
- 2.6.17-rc6-git7

Anyone have any suggestions or ideas on this?

Ian
