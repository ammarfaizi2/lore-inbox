Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261986AbREPPxL>; Wed, 16 May 2001 11:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261987AbREPPxB>; Wed, 16 May 2001 11:53:01 -0400
Received: from c1473286-a.stcla1.sfba.home.com ([24.176.137.160]:35844 "HELO
	ocean.lucon.org") by vger.kernel.org with SMTP id <S261986AbREPPwv>;
	Wed, 16 May 2001 11:52:51 -0400
Date: Wed, 16 May 2001 08:52:49 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Jalaja Devi <jalajad@yahoo.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bad udelay usage in drivers/net/aironet4500_card.c
Message-ID: <20010516085249.B2003@lucon.org>
In-Reply-To: <20010516123312.978.qmail@web4303.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010516123312.978.qmail@web4303.mail.yahoo.com>; from jalajad@yahoo.com on Wed, May 16, 2001 at 05:33:12AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2001 at 05:33:12AM -0700, Jalaja Devi wrote:
> Hi!
> Could you please tell me how you fixed the udelay
> problem. cuz, I am encountering the same problem in my
> driver.
> 

I am not a kernel expert. You should ask it on the kernel mailing
list.

> Thanks for your time,
> Jalaja
> 
> 
> In 2.4.4, drivers/net/aironet4500_card.c has 
> 
> 
> # grep udelay linux/drivers/net/aironet4500_card.c 
>                 udelay(1000); 
>         udelay(100); 
>                 udelay(10); 
>         udelay(100000); 
>         udelay(200000); 
>         udelay(250000); 
>         udelay(10000); 
>         udelay(10000); 
>         udelay(1000); 
>         udelay(1000); 
>         udelay(10000); 
> 
> 
> But on ia32, you cannot use more than 20000 for udelay
> (). You will get 
> undefined symbol, __bad_udelay. 
> 
> 
> 
> 
> __________________________________________________
> Do You Yahoo!?
> Yahoo! Auctions - buy the things you want at great prices
> http://auctions.yahoo.com/
