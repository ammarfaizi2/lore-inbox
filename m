Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292316AbSBUEQw>; Wed, 20 Feb 2002 23:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292321AbSBUEQm>; Wed, 20 Feb 2002 23:16:42 -0500
Received: from web12308.mail.yahoo.com ([216.136.173.106]:30215 "HELO
	web12308.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S292316AbSBUEQX>; Wed, 20 Feb 2002 23:16:23 -0500
Message-ID: <20020221041622.16473.qmail@web12308.mail.yahoo.com>
Date: Wed, 20 Feb 2002 20:16:22 -0800 (PST)
From: Raghu Angadi <raghuangadi@yahoo.com>
Subject: Re: memory corruption in tcp bind hash buckets on SMP? 
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020213.190743.66058963.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- "David S. Miller" <davem@redhat.com> wrote:
>    From: Raghu Angadi <raghuangadi@yahoo.com>
>    Date: Wed, 13 Feb 2002 16:51:52 -0800 (PST)    
>    --- "David S. Miller" <davem@redhat.com> wrote:
>    > 
>    > This bug is fixed in the 2.4.9 Red Hat 7.2 errata kernels.

We tried the latest errata kernel from redhat.com (2.4.9-21). This one still
has the same problem. We saw exactly the same problem at the same place in
the code. I can add the oops here if you like. 

(link to the original mail for this thread:
	http://www.uwsg.iu.edu/hypermail/linux/kernel/0202.1/1193.html)

We are trying to fix this problem but did not have much success yet. I will
happy to provide any more info if somebody needs.

Raghu.
   
>    Thanks, Is the following diff the only culprit/fix?
>    
> There are others, seatch for more instances of tcp_tw_get()
> and tcp_tw_put() and things like atomic_set(tw->count, 1);


__________________________________________________
Do You Yahoo!?
Yahoo! Sports - Coverage of the 2002 Olympic Games
http://sports.yahoo.com
