Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262449AbTCJWzL>; Mon, 10 Mar 2003 17:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262452AbTCJWzL>; Mon, 10 Mar 2003 17:55:11 -0500
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:17288 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S262449AbTCJWzJ>; Mon, 10 Mar 2003 17:55:09 -0500
Message-ID: <20030310230539.30103.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
To: akpm@digeo.com, george@mvista.com
Cc: torvalds@transmeta.com, cobra@compuserve.com, linux-kernel@vger.kernel.org
Date: Tue, 11 Mar 2003 00:05:39 +0100
Subject: Re: Runaway cron task on 2.5.63/4 bk?
X-Originating-Ip: 213.4.13.153
X-Originating-Server: ws5-7.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: Andrew Morton <akpm@digeo.com> 
Date: 	Mon, 10 Mar 2003 14:29:44 -0800 
To: george anzinger <george@mvista.com> 
Subject: Re: Runaway cron task on 2.5.63/4 bk? 
 
> If an app wants to sleep forever, calling 
>  
> 	while (1) 
> 		sleep(MAX_INT); 
>  
> seems like a reasonable approach.  I'd expect quite a lot of applications 
> would be doing that. 
 
why not sleep(0)? 
 
   Felipe 
 
-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
