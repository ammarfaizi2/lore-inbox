Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267443AbTAWX6K>; Thu, 23 Jan 2003 18:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267431AbTAWX6K>; Thu, 23 Jan 2003 18:58:10 -0500
Received: from 205-158-62-139.outblaze.com ([205.158.62.139]:22191 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S267443AbTAWX6G>; Thu, 23 Jan 2003 18:58:06 -0500
Message-ID: <20030124000711.98366.qmail@mail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Lee Chin" <leechin@mail.com>
To: lm@bitmover.com, leechin@mail.com
Cc: linux-kernel@vger.kernel.org, linux-newbie@vger.kernel.org
Date: Thu, 23 Jan 2003 19:07:11 -0500
Subject: Re: debate on 700 threads vs asynchronous code
X-Originating-Ip: 66.123.16.67
X-Originating-Server: ws1-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Thanks for the rpely... my question was more so, with setcontext and swapcontext, I will still be messing with the data cache right?  

In otherwords, as long as I have an async system with out setcontext, I know I am good... but with it, havent I degraded to a threaded environment?

Thanks
Lee
----- Original Message -----
From: Larry McVoy <lm@bitmover.com>
Date: Thu, 23 Jan 2003 15:28:34 -0800
To: Lee Chin <leechin@mail.com>
Subject: Re: debate on 700 threads vs asynchronous code

> > b) Write an asycnhrounous system with only 2 or three threads where I manage the connections and stack (via setcontext swapcontext etc), which is progromatically a little harder
> > 
> > Which way will yeild me better performance, considerng both approaches are implemented optimally?
> 
> If this is a serious question, an async system will by definition do better.
> You have either 700 stacks screwing up the data cache or 2-3 stacks nicely
> fitting in the data cache.  Ditto for instruction cache, etc.
> -- 
> ---
> Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 

-- 
__________________________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

Meet Singles
http://corp.mail.com/lavalife

