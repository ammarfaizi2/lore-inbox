Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261650AbULFVOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbULFVOq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 16:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbULFVOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 16:14:46 -0500
Received: from 209-128-68-125.bayarea.net ([209.128.68.125]:37779 "EHLO
	hera.kernel.org") by vger.kernel.org with ESMTP id S261650AbULFVOo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 16:14:44 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [RFC] dynamic syscalls revisited
Date: Mon, 6 Dec 2004 21:14:25 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <cp2i3h$hs0$1@terminus.zytor.com>
References: <1101741118.25841.40.camel@localhost.localdomain> <20041129151741.GA5514@infradead.org> <Pine.LNX.4.53.0411291740390.30846@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1102367665 18305 127.0.0.1 (6 Dec 2004 21:14:25 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 6 Dec 2004 21:14:25 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.53.0411291740390.30846@yvahk01.tjqt.qr>
By author:    Jan Engelhardt <jengelh@linux01.gwdg.de>
In newsgroup: linux.dev.kernel
> 
> I do not see how dsyscalls could be better than static ones, so they are
> one-on-one. Maybe someone could elaborate why they are "a really bad idea"?
> 

Because we already have a name resolution mechanism in the kernel,
called the filesystem?  We also have a mechanism for ad hoc system
calls, it's called ioctl().

And before you go "but ioctl() sucks": dynamic syscalls suck for
*exactly* the same reasons.

	-hpa
