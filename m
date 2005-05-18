Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbVERCvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbVERCvc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 22:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbVERCvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 22:51:32 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:61155 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262061AbVERCv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 22:51:29 -0400
Subject: Re: Illegal use of reserved word in system.h
From: Steven Rostedt <rostedt@goodmis.org>
To: "Gilbert, John" <JGG@dolby.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2692A548B75777458914AC89297DD7DA08B0866D@bronze.dolby.net>
References: <2692A548B75777458914AC89297DD7DA08B0866D@bronze.dolby.net>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 17 May 2005 22:51:22 -0400
Message-Id: <1116384682.9737.61.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-17 at 17:51 -0700, Gilbert, John wrote:
> Hello,
> The use of "new" as a variable name in the macro "__cmpxchg" breaks
> builds of other programs that link to include/asm-i386/system.h
> I'd like to request that this be renamed to something else, like mynew
> or krnew.

mynew is for beginner programmers (and perl scripts!).  The normal
convention is to add a "k" as in printk or ksoftirqd, so it should be
"knew". But who knew?

Besides, what programs are you compiling that are using kernel headers?
That's always a no-no. Although I did notice that errno.h on debian
includes bits/errno.h which includes linux/errno.h. But that's the
distribution's linux headers, and I don't see any header including
asm/system.h


> Thanks.
> John Gilbert
> jgg@dolby.com
> 
> -----------------------------------------
> This message (including any attachments) may contain confidential
> information intended for a specific individual and purpose.  If you are not
> the intended recipient, delete this message.  If you are not the intended
> recipient, disclosing, copying, distributing, or taking any action based on
> this message is strictly prohibited.

Is this a joke? It doesn't make sense sending a disclaimer like this to
a mailing list!

-- Steve


