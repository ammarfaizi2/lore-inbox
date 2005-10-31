Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932469AbVJaGSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbVJaGSO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 01:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbVJaGSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 01:18:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57790 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932469AbVJaGSM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 01:18:12 -0500
Date: Sun, 30 Oct 2005 23:17:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rob Landley <rob@landley.net>
Cc: ak@suse.de, rmk+lkml@arm.linux.org.uk, torvalds@osdl.org,
       tony.luck@gmail.com, paolo.ciarrocchi@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: New (now current development process)
Message-Id: <20051030231723.71c72865.akpm@osdl.org>
In-Reply-To: <200510302305.46532.rob@landley.net>
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com>
	<20051030111241.74c5b1a6.akpm@osdl.org>
	<200510310148.57021.ak@suse.de>
	<200510302305.46532.rob@landley.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley <rob@landley.net> wrote:
>
> You seem to want 
>  a tree where the only stuff likely to break is your stuff

That's what I was thinking ;)

The simple fact is that we have more developers doing more stuff faster
than they used to.  All within a coupled system which has a lot of
interactions.

End result: yes, we do all need to spend more time looking at other
people's code and less time looking at our own.  That's just life in a
large project.

I'm very careful to make sure that relevant developers are copied on
patches which go into -mm.  In fact there's significantly better review
opportunity on patches which go developer->mm->Linus than there are on
patches which go developer->maintainer-git->Linus.

But the cc'ed people just _have_ to take time out to read the dang patch! 
They almost always have multiple weeks in which to do this.  But if they
just delete the thing while they work on their own stuff, well...
