Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263037AbTCWMH0>; Sun, 23 Mar 2003 07:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263040AbTCWMH0>; Sun, 23 Mar 2003 07:07:26 -0500
Received: from sysdoor.net ([62.212.103.239]:55565 "EHLO celia")
	by vger.kernel.org with ESMTP id <S263037AbTCWMHZ>;
	Sun, 23 Mar 2003 07:07:25 -0500
Date: Sun, 23 Mar 2003 13:18:18 +0100
From: Michael Vergoz <mvergoz@sysdoor.com>
To: "shesha bhushan" <bhushan_vadulas@hotmail.com>
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: Re: inet_addr Equivalent
Message-Id: <20030323131818.0a66b59a.mvergoz@sysdoor.com>
In-Reply-To: <F110LwR2ozm2F4mOKbA0000952b@hotmail.com>
References: <F110LwR2ozm2F4mOKbA0000952b@hotmail.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Look at : 
/* Convert from presentation format of an Internet number in buffer
   starting at CP to the binary network format and store result for
   interface type AF in buffer starting at BUF.  */
extern int inet_pton (int __af, __const char *__restrict __cp,
                      void *__restrict __buf) __THROW;

If it doesn't work look in the libc source code :)

regards,
Michael

On Sun, 23 Mar 2003 07:32:05 +0000
"shesha bhushan" <bhushan_vadulas@hotmail.com> wrote:

> 
> Hi all,
> 
> IF i want to use the inet_addr in kernel modules, then how to use. What is 
> the equivalent function to this or which is the header file that I have to 
> include. If I include "arpa/inet.h" and compile as kernel module, I gives 
> whole bunch of errors.
> 
> So please help me how to convert doted IP address to unsigned long inside 
> kernel modules. All help is very mucg apperciated.
> 
> Tahnking You
> Shesha
> 
> 
> 
> 
> 
> _________________________________________________________________
> Get more buddies in your list. Win prizes http://messenger.msn.co.in/promo
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
