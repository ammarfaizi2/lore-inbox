Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbUJaWRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbUJaWRt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 17:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbUJaWRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 17:17:49 -0500
Received: from quechua.inka.de ([193.197.184.2]:9346 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261326AbUJaWRn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 17:17:43 -0500
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: [PATCH] Serial updates
Date: Sun, 31 Oct 2004 23:26:07 +0100
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Message-Id: <pan.2004.10.31.22.26.06.750412@dungeon.inka.de>
References: <20041031175114.B17342@flint.arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have trouble with smart card readers and smart cards,
and somehow I think it might be kernel 2.6.*,
as people with the same hw and sw report no problems
with kernel 2.4.

Should I try this patch? anything in it that could help
me? or are there known problems?

In an strace I saw a poll/read loop read data and
got 8 bytes at a time. once it 16 bytes were lost.
I can't reproduce the errors, but they happen very
often (in every run of the regression test suite
I have).

I have no idea if my kernel config could have
anything to do with it, if it helps I will
post/link it.

Andreas

