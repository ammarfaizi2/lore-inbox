Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292043AbSBAVGO>; Fri, 1 Feb 2002 16:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292028AbSBAVGF>; Fri, 1 Feb 2002 16:06:05 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8201 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292050AbSBAVF4>;
	Fri, 1 Feb 2002 16:05:56 -0500
Message-ID: <3C5B0312.40DB82AB@zip.com.au>
Date: Fri, 01 Feb 2002 13:05:22 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bob Miller <rem@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.3 remove global semaphore_lock spin lock.
In-Reply-To: <20020131150139.A1345@doc.pdx.osdl.net> <3C59D956.4F2B85DB@zip.com.au>,
		<3C59D956.4F2B85DB@zip.com.au> <20020201125234.A1418@doc.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob Miller wrote:
> 
> Also, at your suggestion I set wait.h:USE_RW_WAIT_QUEUE_SPINLOCK on
> a clean 2.5.3 system to test.  The problem is that it OOPs on startup.

OK, someone broke it; possibly the scheduler changes.  Not surprising,
really.

It'd be nice to have it fixed, but I wouldn't suggest that you
bust a gut over it.   Certainly your patch shouldn't be held up by
this.  An oops trace would be useful.

-
