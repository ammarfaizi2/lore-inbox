Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbUKNJNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbUKNJNq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 04:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbUKNJMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 04:12:12 -0500
Received: from mail.shareable.org ([81.29.64.88]:34946 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261268AbUKNJKt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 04:10:49 -0500
Date: Sun, 14 Nov 2004 09:10:30 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Martin Schlemmer <azarah@nosferatu.za.org>, linux-kernel@vger.kernel.org,
       Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@elte.hu>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: Re: 2.6.10-rc1-mm5 [u]
Message-ID: <20041114091030.GA24582@mail.shareable.org>
References: <20041111012333.1b529478.akpm@osdl.org> <1100368553.12239.3.camel@nosferatu.lan> <1100380593.12663.1.camel@nosferatu.lan> <20041113132232.5c201000.akpm@osdl.org> <1100384533.12195.3.camel@nosferatu.lan> <20041113152457.6cb0fedb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041113152457.6cb0fedb.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Don't know.  It's hard to see why that patch would cause gross misbehaviour
> in evolution and apache.  We may have to just revert it and take another
> look at the problem which it fixes.

I just realised I have posted an answer to this, under a different
subject, but forgot to use the right In-Reply-To so that it will
appear in this thread.

The subject is "Futex queue_me/get_user ordering", and the short
answer is that the patch is buggy and it does cause these problems.

-- Jamie
