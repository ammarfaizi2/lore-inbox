Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263578AbTDNRS5 (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 13:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263580AbTDNRS5 (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 13:18:57 -0400
Received: from chaos.analogic.com ([204.178.40.224]:61322 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263578AbTDNRSz (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 13:18:55 -0400
Date: Mon, 14 Apr 2003 13:32:58 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: hendriks@lanl.gov
cc: Christoph Hellwig <hch@infradead.org>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: Syscall numbers for BProc
In-Reply-To: <20030414171801.GI12496@lanl.gov>
Message-ID: <Pine.LNX.4.53.0304141329470.26514@chaos>
References: <20030404193218.GD15620@lanl.gov> <20030404203531.A29501@infradead.org>
 <20030405004427.GG15620@lanl.gov> <20030405064559.A2331@infradead.org>
 <20030405201537.GA18755@lanl.gov> <20030410072910.A15440@infradead.org>
 <20030414171801.GI12496@lanl.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FYI, these syscall numbers are "available", at least for
private tests:

break()                                 = -1 ENOSYS (Function not implemented)
stty(0x1, 0x1)                          = -1 ENOSYS (Function not implemented)
gtty(0x2, 0x2)                          = -1 ENOSYS (Function not implemented)
ftime()                                 = -1 ENOSYS (Function not implemented)
prof()                                  = -1 ENOSYS (Function not implemented)
acct(0x8048e4a)                         = -1 ENOSYS (Function not implemented)
lock()                                  = -1 ENOSYS (Function not implemented)
mpx()                                   = -1 ENOSYS (Function not implemented)

Note that nobody can even call break() from the 'C' language. The
name is reserved ;^) This is probably a good candidate for the
next permanent name change.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

