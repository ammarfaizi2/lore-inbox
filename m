Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266617AbUGKPgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266617AbUGKPgw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 11:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266618AbUGKPgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 11:36:51 -0400
Received: from mail.dif.dk ([193.138.115.101]:29841 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S266617AbUGKPgc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 11:36:32 -0400
Date: Sun, 11 Jul 2004 17:35:04 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Con Kolivas <kernel@kolivas.org>
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Go Taniguchi <go@turbolinux.co.jp>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: post 2.6.7 BK change breaks Java?
In-Reply-To: <40F15A86.1030208@kolivas.org>
Message-ID: <Pine.LNX.4.56.0407111730440.23998@jjulnx.backbone.dif.dk>
References: <40F15A86.1030208@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jul 2004, Con Kolivas wrote:
> Jesper Juhl wrote:
> > Ok, got them all 3 backed out of 2.6.7-mm7 , but that doesn't change a
> > thing. The JVM still dies when I try to run eclipse.
> Sorry someone else reported success with this:
> quote:
> ------
> If I removed this changeset, java worked.
> http://linux.bkbits.net:8080/linux-2.6/cset@1.1743
> ------
> Sorry I was hoping others saw this.

Yeah, now that you mention it I see the mail from Go Taniguchi, missed it
before.

I can confirm his findings. I just now grabbed that cset as a diff and
backed it out of 2.6.7-mm7 and that fixes the problem.

Now all we need it someone knowledgable about the changes made by that
cset to review it and find out exactely what causes the breakage.

--
Jesper Juhl <juhl-lkml@dif.dk>

