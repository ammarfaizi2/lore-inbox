Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266402AbUAICus (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 21:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266406AbUAICus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 21:50:48 -0500
Received: from [61.51.122.197] ([61.51.122.197]:14839 "EHLO
	kapok.exavio.com.cn") by vger.kernel.org with ESMTP id S266402AbUAICur
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 21:50:47 -0500
Date: Fri, 9 Jan 2004 10:53:14 +0800
From: Isaac Claymore <clay@exavio.com.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.1-rc2-mm1][BUG] kernel BUG at mm/rmap.c:305!
Message-ID: <20040109025314.GA4259@exavio.com.cn>
Mail-Followup-To: Isaac Claymore <clay@exavio.com.cn>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <1073605394.1070.3.camel@debian> <20040109013553.GA3755@exavio.com.cn> <20040108181116.530608a0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040108181116.530608a0.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 08, 2004 at 06:11:16PM -0800, Andrew Morton wrote:
> Isaac Claymore <clay@exavio.com.cn> wrote:
> >
> > I got a similar problem after running rc2-mm1 for about 12 hours,
> >  and my window manager got killed as a result.
> 
> Sorry, it's a turkey.  rc3-mm1 will be better, I promise.
> 
Just after having read your message, it bit again. This time there's
also a "bad: scheduling while atomic!" error. I guess it must've been
reported already. I've included a snipped dmesg, just to provide more
context to help trace down the bug.

Also, I misread your "turkey" as a "turnkey" at a first glance ;)


-- 

Regards, Isaac
()  ascii ribbon campaign - against html e-mail
/\                        - against microsoft attachments
