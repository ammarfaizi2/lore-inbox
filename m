Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261590AbUK1WsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbUK1WsS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 17:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbUK1WsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 17:48:18 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:48823 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261596AbUK1Wqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 17:46:31 -0500
Subject: Re: Suspend 2 merge: 9/51: init/* changes.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E1CY2Vm-0004LQ-00@chiark.greenend.org.uk>
References: <20041127072224.GM1417@openzaurus.ucw.cz>
	 <E1CXyvo-0002LS-00@gondolin.me.apana.org.au>
	 <E1CY2Vm-0004LQ-00@chiark.greenend.org.uk>
Content-Type: text/plain
Message-Id: <1101681784.4343.309.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 29 Nov 2004 09:43:04 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sun, 2004-11-28 at 00:21, Matthew Garrett wrote:
> Herbert Xu <herbert@gondor.apana.org.au> wrote:
> > Pavel Machek <pavel@ucw.cz> wrote:
> >> Given it is not too intrusive... why not. Send it for comments.
> >> I probably will not use this myself, so you'll need to test/maintain
> >> it.
> > 
> > This shouldn't be necessary.  Since the resume is being initiated by
> > userspace, it can perform the function of name_to_dev_t and just feed
> > the numbers to the kernel.  The code to do that is still in Debian's
> > initrd-tools.
> 
> Good point. Ok, what's the best way to present this to userspace? Add a
> /sys/power/resume and then echo a major:minor in there?

If you're ever going to add swapfile support, you're also going to want
to be able to specify the blocksize and block at which the swapheader
begins.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

