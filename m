Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286172AbRLTGJb>; Thu, 20 Dec 2001 01:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286170AbRLTGJT>; Thu, 20 Dec 2001 01:09:19 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:51210 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S286166AbRLTGIV>; Thu, 20 Dec 2001 01:08:21 -0500
Message-ID: <3C218014.48597D84@zip.com.au>
Date: Wed, 19 Dec 2001 22:07:16 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: blesson paul <blessonpaul@msn.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: exported functions in 2.2.16
In-Reply-To: <F38RfLC7A9BzqREGcvc0000f97a@hotmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

blesson paul wrote:
> 
> Hi all
>         I am using  kernel 2.2.16.  I  need to use the following functions which of
> course are exported from a kernel 2.4.5.
> 
>         interruptible_sleep_on_timeout

That has been exported since forever.  Maybe you have a build problem?

>         schedule_task

Was first introduced into the 2.2 series at 2.2.19-pre16.  It
is exported there also.

-
