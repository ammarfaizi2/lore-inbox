Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266804AbTBCPwq>; Mon, 3 Feb 2003 10:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266805AbTBCPwq>; Mon, 3 Feb 2003 10:52:46 -0500
Received: from pointblue.com.pl ([62.121.131.135]:62983 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id <S266804AbTBCPwp>;
	Mon, 3 Feb 2003 10:52:45 -0500
Subject: Re: [BUG] vmalloc, kmalloc - 2.4.x
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030203155225.A5968@flint.arm.linux.org.uk>
References: <1044285222.2396.14.camel@gregs>
	 <1044285758.2527.8.camel@laptop.fenrus.com>
	 <1044286926.2396.28.camel@gregs>
	 <20030203155225.A5968@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: K4 Labs
Message-Id: <1044288452.2433.34.camel@gregs>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 03 Feb 2003 16:07:32 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-03 at 15:52, Russell King wrote:
> On Mon, Feb 03, 2003 at 03:42:06PM +0000, Grzegorz Jaskiewicz wrote:
> > > and that
> > >         printk("<1>%d\n", TimerIntrpt);
> > > you shouldn't use <1> in printk strings ever.
> > <1>gives me messages on screen on my box, thats why.
> > 
> > the same effect is while using kmalloc, just change vmalloc to kmalloc.
> 
> #include <linux/kernel.h>
> 
> and then use
> 
> printk(KERN_CRIT "%d\n", TimerIntrpt);
> 
> We have these definitions for a reason. 8)

Thx guys, i am concidering this as my lack of information. 
But anyway, i am really impressed in spead of response.

Chears :)

-- 

Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 Labs

