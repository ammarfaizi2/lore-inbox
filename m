Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbWCVHw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbWCVHw7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 02:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbWCVHw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 02:52:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1757 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751082AbWCVHw6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 02:52:58 -0500
Date: Tue, 21 Mar 2006 23:49:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Luke Yang" <luke.adi@gmail.com>
Cc: rgetz@blackfin.uclinux.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2]Blackfin archtecture patche for 2.6.16
Message-Id: <20060321234935.1d006a13.akpm@osdl.org>
In-Reply-To: <489ecd0c0603212342w4124dddfy1bb50c02984c0e8f@mail.gmail.com>
References: <6.1.1.1.0.20060321224917.01ec6970@ptg1.spd.analog.com>
	<20060321223652.25bf07f7.akpm@osdl.org>
	<489ecd0c0603212342w4124dddfy1bb50c02984c0e8f@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Luke Yang" <luke.adi@gmail.com> wrote:
>
>  > More things might come out once people start paying more attention, but if
>  > that's the extent of things, I'd be OK with a merge when you're ready.
>    Does this merge has to be within 1 week after the release, so we
>  have to wait for 2.6.17? Or this can be done on mm-tree?

The whole patch affects just one line in one Kconfig file outside
arch/bluefin, so I don't see a reason why this needs to be tied into the
two-week-window thing.  I figure that if we can get it into -mm within a
few weeks we'll be OK for 2.6.17.

But that depends upon review comments.  My ten-minute-peek was not
sufficient.  But given this discussion and its probably appearance in -mm,
I'd expect a few more people will get in there and help.

We'll see how it goes.
