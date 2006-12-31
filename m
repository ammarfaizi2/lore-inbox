Return-Path: <linux-kernel-owner+w=401wt.eu-S933179AbWLaNud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933179AbWLaNud (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 08:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933182AbWLaNud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 08:50:33 -0500
Received: from aa015msg.fastweb.it ([213.140.2.82]:33869 "EHLO
	aa015msg.fastweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933179AbWLaNud (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 08:50:33 -0500
Date: Sun, 31 Dec 2006 14:50:31 +0100
From: Andrea Gelmini <gelma@gelma.net>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VM: Fix nasty and subtle race in shared mmap'ed page writeback
Message-ID: <20061231135031.GC23445@gelma.net>
References: <200612291859.kBTIx2kq031961@hera.kernel.org> <20061229224309.GA23445@gelma.net> <459734CE.1090001@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459734CE.1090001@yahoo.com.au>
Weight: 77.8 kg (171.51964 lbs)
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 31, 2006 at 02:55:58PM +1100, Nick Piggin wrote:
> This bug was only introduced in 2.6.19, due to a change that caused pte
no, Linus said that with 2.6.19 it's easier to trigger this bug...

> So if your corruption is years old, then it must be something else.
> Maybe it is hidden by a timing change, or BDB isn't using msync properly.
I can give you a complete image where just changing kernel (everything
is same, of course) corruptions goes away.
we spent a lot, I mean a *lot*, of time looking for our code mistake,
and so on.
I don't want to seem rude, but I am sure that Berkeley DB corruption we
have seen (not just Klibido, but I also think about postgrey, and so on)
depends on this bug.
I repeat, if you have time/interest I can give you a complete machine
to see the problem.

thanks a lot for your time,
gelma
