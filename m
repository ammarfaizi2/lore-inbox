Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131346AbRCXAmH>; Fri, 23 Mar 2001 19:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131429AbRCXAlu>; Fri, 23 Mar 2001 19:41:50 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:40388 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131346AbRCXAlm>; Fri, 23 Mar 2001 19:41:42 -0500
Message-ID: <3ABBED86.3B7ED60B@uow.edu.au>
Date: Sat, 24 Mar 2001 11:42:46 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.3-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "J . A . Magallon" <jamagallon@able.es>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gcc-3.0 warnings
In-Reply-To: <20010323162956.A27066@ganymede.isdn.uiuc.edu> <Pine.LNX.4.31.0103231433380.766-100000@penguin.transmeta.com>,
		<Pine.LNX.4.31.0103231433380.766-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Mar 23, 2001 at 23:34:15 +0100 <20010323235909.C3098@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J . A . Magallon" wrote:
> 
>  The same is with that ugly out: at the end
> of the function. Just change all that 'goto out' for a return.

Oh no, no, no.  Please, no.

Multiple return statements are a maintenance nightmare.

Go back and look at the "checker" reports.  Think about them.

-
