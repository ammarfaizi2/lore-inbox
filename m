Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268383AbUHQS2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268383AbUHQS2S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 14:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268387AbUHQS2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 14:28:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:36826 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268383AbUHQS2K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 14:28:10 -0400
Date: Tue, 17 Aug 2004 11:26:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] 2.6.8-rc4-mm1 - Fix UML build
Message-Id: <20040817112629.04c7f672.akpm@osdl.org>
In-Reply-To: <200408171915.i7HJF5KF003348@ccure.user-mode-linux.org>
References: <200408120414.i7C4EtJd010481@ccure.user-mode-linux.org>
	<20040815150635.5ac4f5df.akpm@osdl.org>
	<200408170602.i7H62LNj019126@ccure.user-mode-linux.org>
	<20040816220816.1b30fd53.akpm@osdl.org>
	<200408171915.i7HJF5KF003348@ccure.user-mode-linux.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike <jdike@addtoit.com> wrote:
>
>  akpm@osdl.org said:
>  > Thanks.  Where do we stand now with getting all this stuff merged up?
>  > Are the patches in -mm suitable?  Did the controversial blockdev stuff
>  > get cleaned up? (it looks like it did...). 
> 
>  Not really, the code is still there but it's not built.  Below is a patch
>  which removes it totally.

Thanks.

>  I also have to get rid of ghash.h and fix some inappropriate intimacy between
>  one of the drivers and VFS.

OK.

>  I'd also wouldn't mind breaking up the big UML patch into somewhat more sane 
>  pieces.  Can I do something like break pieces off it, send them plus the 
>  smaller big patch, and have you subsititute them for the current big patch?

Feel free if you think there's some benefit in that.

>  Is that preferable to dropping the current patches on Linus, or would you
>  rather send him what you have, in more or less its current form, once it's
>  been tidied up?

Frankly, when a subsystem gets this far out of date I don't think it
matters a lot - nobody has much hope of following all the changes anyway. 
We'll just merge the megapatch on the assumption that Jeff knows what he's
doing, and that it's better than what we had before.  You should have seen
the size of some of those MIPS patches ;)

