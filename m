Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265971AbUHWQM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265971AbUHWQM2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 12:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265784AbUHWQLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 12:11:44 -0400
Received: from dns1.seagha.com ([217.66.0.18]:42148 "EHLO ndns1.seagha.com")
	by vger.kernel.org with ESMTP id S265978AbUHWQJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 12:09:56 -0400
Message-ID: <6DED3619289CD311BCEB00508B8E133601A68B13@nt-server2.antwerp.seagha.com>
From: Karl Vogel <karl.vogel@seagha.com>
To: "'Jens Axboe'" <axboe@suse.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Kernel 2.6.8.1: swap storm of death - CFQ scheduler=culprit
Date: Mon, 23 Aug 2004 18:10:55 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Jens, is this huge amount of bio/biovec's allocations 
> expected with CFQ? Its really really bad.
> 
> Nope, it's not by design :-)
> 
> A test case would be nice, then I'll fix it as soon as possible. But
> please retest with 2.6.8.1 marcelo, 2.6.8-rc4 is missing an important
> fix to ll_rw_blk that can easily cause this. The first report is for
> 2.6.8.1, so I'm more puzzled on that.

I tried with 2.6.8.1 and 2.6.8.1-mm4, both had the problem. If there 
is anything extra I need to try/record, just shoot!

Original post with testcase + stats:
  http://article.gmane.org/gmane.linux.kernel/228156

