Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267920AbTAMFwR>; Mon, 13 Jan 2003 00:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267923AbTAMFwR>; Mon, 13 Jan 2003 00:52:17 -0500
Received: from granger.mail.mindspring.net ([207.69.200.148]:17937 "EHLO
	granger.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S267920AbTAMFwQ>; Mon, 13 Jan 2003 00:52:16 -0500
Message-ID: <3E225657.30304@emageon.com>
Date: Mon, 13 Jan 2003 00:01:59 -0600
From: Brian Tinsley <btinsley@emageon.com>
Organization: Emageon
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: qla2300 driver stability, (was Re: 2.4.20, .text.lock.swap cpu
 usage?)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>>problem. I've had this driver running in my lab and at numerous client 
>>sites for quite some time and have never seen it even burp.
>>    
>>
>
>how hard did you push it in testing?
>
I've hit it with simulations of client loads as well as outright abusive 
load testing for several days nonstop without problem.

>in some configurations i've had to subject it to many hours of
>intensive IO (ie multiple concurrent and continious bonnie++ runs of
>varying file sizes) in order to get it to spin in
>qla2x00_intr_handler. but it will eventually hang given enough IO ime.  
>(in other configurations, heavy sustained IO will lock it up in
>minutes, even seconds).
>
Maybe I need to load bonnie++ in the lab and see what happens.


-- 

Brian Tinsley
Chief Systems Engineer
Emageon


