Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbVKLP7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbVKLP7I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 10:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbVKLP7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 10:59:07 -0500
Received: from mail.linicks.net ([217.204.244.146]:38594 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S932405AbVKLP7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 10:59:06 -0500
From: Nick Warne <nick@linicks.net>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] ext3: Fix warning without quota support (was: Linux 2.6.14)
Date: Sat, 12 Nov 2005 15:58:56 +0000
User-Agent: KMail/1.8.1
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200511121412.35029.nick@linicks.net> <20051112163153.6b54ee83.khali@linux-fr.org>
In-Reply-To: <20051112163153.6b54ee83.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511121558.56357.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

On Saturday 12 November 2005 15:31, Jean Delvare wrote:
> Hi Nick,
>
> > I have added this small fix to my 2.6.14.2 build.  A quick question.
>
> Let is be noted that this warning was fixed in a completely different
> way in Linus' tree already. My patch is not meant for -stable either,
> as it doesn't fix any real problem.

I see (or didn't).  Isn't it hard to keep up with all this.  Kernel developers 
are unstoppable... how Linus/Andrew/Alan/all_the_rest keep on top of it all I 
don't know - wonderful stuff.

> > What does GCC do here - does it just drop and ignore the unused variable?
>
> Without optimizations, gcc 3.3.6 keeps the variable although it won't
> ever be used. With -O1 and above (including -Os) it drops the unused
> variable.

Thanks!  I didn't know that at all.

Nick
-- 
http://sourceforge.net/projects/quake2plus

"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb

