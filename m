Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267346AbUH0UKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267346AbUH0UKt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 16:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267538AbUH0UIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 16:08:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:22200 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267571AbUH0Tsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 15:48:50 -0400
Date: Fri, 27 Aug 2004 12:48:37 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Christoph Hellwig <hch@lst.de>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove tpqic02 from tree
In-Reply-To: <20040827193625.GA810@lst.de>
Message-ID: <Pine.LNX.4.58.0408271244470.14196@ppc970.osdl.org>
References: <20040827193306.GA643@lst.de> <20040827193625.GA810@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Aug 2004, Christoph Hellwig wrote:
>
> I'm an idiot as I used Linus' old transmeta address again.

That's ok. We're all idiots.

However, in this case the patch is wrong, for reasons you couldn't know: 
since people pointed out the problems with the thing, I contacted Hennus 
(google is your friend - don't use old emails addresses), and he replied:

	Date: Tue, 24 Aug 2004 13:14:15 +0200
	From: Hennus Bergman <hennus@pobox.com>
	To: Linus Torvalds <torvalds@osdl.org>
	Subject: Re: serious license problems with tpqic02.c

	Hi Linus,
	
	I'll send a more detailed email later this week but putting a GPL 
	license on it will probably be fine.
	
	Hennus

so we should at least wait for that. So far I haven't heard anything else.

Now, if it's true that the driver can't actually work, and hasn't worked 
in a long time, that's a different issue, but I'd like somebody to verify 
that first. If nobody uses the driver any more, we can certainly decide to 
remove it just for that reason. Does it compile? Have distribution makers 
had any reports about that driver in the last couple of years?

		Linus
