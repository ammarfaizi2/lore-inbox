Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266637AbTBCP10>; Mon, 3 Feb 2003 10:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266765AbTBCP10>; Mon, 3 Feb 2003 10:27:26 -0500
Received: from pointblue.com.pl ([62.121.131.135]:48135 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id <S266637AbTBCP1W>;
	Mon, 3 Feb 2003 10:27:22 -0500
Subject: Re: [BUG] vmalloc, kmalloc - 2.4.x
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: arjanv@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1044285758.2527.8.camel@laptop.fenrus.com>
References: <1044285222.2396.14.camel@gregs>
	 <1044285758.2527.8.camel@laptop.fenrus.com>
Content-Type: text/plain
Organization: K4 Labs
Message-Id: <1044286926.2396.28.camel@gregs>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 03 Feb 2003 15:42:06 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-03 at 15:22, Arjan van de Ven wrote:
> On Mon, 2003-02-03 at 16:13, Grzegorz Jaskiewicz wrote:

> forgot to tell you that
> 
>     ttimer.expires = jiffies+(HZ/150.0);
> 
> 
> you CANNOT use floating point in kernel mode! And that for HZ=100 this
> gives you a timer that expires immediatly.

In real world i am NOT using this timer that way, so please don't even
bother yourself telling me that this way is wrong, becouse i know it is
not completly ok.


> 
> and that
>         printk("<1>%d\n", TimerIntrpt);
> you shouldn't use <1> in printk strings ever.
<1>gives me messages on screen on my box, thats why.

the same effect is while using kmalloc, just change vmalloc to kmalloc.


-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 Labs

