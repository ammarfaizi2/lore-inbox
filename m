Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265263AbUEVAtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265263AbUEVAtc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 20:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265125AbUEVAqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 20:46:05 -0400
Received: from web90002.mail.scd.yahoo.com ([66.218.94.60]:61369 "HELO
	web90002.mail.scd.yahoo.com") by vger.kernel.org with SMTP
	id S264879AbUEVAo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 20:44:29 -0400
Message-ID: <20040520232425.76943.qmail@web90002.mail.scd.yahoo.com>
Date: Thu, 20 May 2004 16:24:25 -0700 (PDT)
From: sai narasimhamurthy <sai_narasi@yahoo.com>
Subject: Re: source changes without kernel re-compiling
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0405191322410.1078@chaos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

is it possible to avoid even system reboots? 
(someway to make ordinary source files like tcp.c work
like modules, that is)
thanks,
Sai



--- "Richard B. Johnson" <root@chaos.analogic.com>
wrote:
> On Wed, 19 May 2004, sai narasimhamurthy wrote:
> 
> > Hi ,
> > I am working with the Linux networking source code
> for
> > the first time.
> > I am working with the file tcp.c in
> > /usr/src/linux/net/ipv4 . Everytime I make a small
> > change, I recompile the kernel. Is there any way
> to
> > get the changes in tcp.c (or any file in /ipv4 ,
> for
> > that matter) reflected without kernel
> re-compiling, so
> > that it saves time?
> > Sai
> >
> 
> You modify the source, then you return to the
> top-level
> directory and execute `make bzImage` or `make
> modules`
> if you are modifying a module. Only the file(s) that
> you modify will get compiled. The final link, of
> course,
> gets done. But that's only a second or two.
> 
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.26 on an i686 machine
> (5557.45 BogoMips).
>             Note 96.31% of all statistics are
> fiction.
> 
> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



	
		
__________________________________
Do you Yahoo!?
Yahoo! Domains – Claim yours for only $14.70/year
http://smallbusiness.promotions.yahoo.com/offer 
