Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbUBUVbs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 16:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbUBUVbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 16:31:48 -0500
Received: from ns2.s-sl.cc ([213.147.180.51]:28434 "EHLO mail.infotainment.cc")
	by vger.kernel.org with ESMTP id S261621AbUBUVbr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 16:31:47 -0500
From: "nolife" <nolife@s-sl.cc>
To: <linux-kernel@vger.kernel.org>
Subject: hotfix for "mremap 2nd"
Date: Sat, 21 Feb 2004 22:30:07 +0100
Message-ID: <KJEEJNCFMHHHNKHGIJDGEEBLDBAA.nolife@s-sl.cc>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,
i created that a few days ago and thought someone might find an interest in
it.
It's a hotfix against the recent mremap bug (missing returnvalue check of
do_munmap()) and can be compiled/loaded as kernelmodule.
It doesn't permit to create more than 60000 VMAs (the default max is 65535).

Can be downloaded here: http://s-sl.cc/mmap.c

best regards,
nolife

