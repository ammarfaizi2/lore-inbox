Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137070AbREKHXa>; Fri, 11 May 2001 03:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137069AbREKHXT>; Fri, 11 May 2001 03:23:19 -0400
Received: from smtp.mountain.net ([198.77.1.35]:56582 "EHLO riker.mountain.net")
	by vger.kernel.org with ESMTP id <S137070AbREKHXF>;
	Fri, 11 May 2001 03:23:05 -0400
Message-ID: <3AFB9324.4BD63B62@mountain.net>
Date: Fri, 11 May 2001 03:22:12 -0400
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.3 i486)
X-Accept-Language: English/United, States, en-US, English/United, Kingdom, en-GB, English, en, French, fr, Spanish, es, Italian, it, German, de, , ru
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Not a typewriter
In-Reply-To: <Pine.LNX.3.95.1010510173138.29690A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> I noticed that my favorite "errno" has now gotten trashed by
> the newer 'C' runtime libraries.
> 
> ENOTTY has been for ages, "Not a typewriter".
> It's now been changed to "Inappropriate ioctl for device".
> 
> Methinks that this means that ../linux/include/asm/errno.h now needs
> to be updated:
> 
> -#define        ENOTTY          25      /* Not a typewriter */
> +#define        ENOTTY          25      /* Inappropriate ioctl for device
> */
> 
> None of these strings are in the kernel, but the headers probably should
> show the "latest standard".
> 
> Cheers,
> Dick Johnson

Probably so, but I think:

character device => typewriter
block => sheet of paper
block device => stack of paper

is not a bad analogy.

Cheers
Tom

PS. I didn't dare call it a ream of paper ;-)

-- 
The Daemons lurk and are dumb. -- Emerson
