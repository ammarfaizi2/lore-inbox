Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262330AbVGWDlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbVGWDlV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 23:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbVGWDlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 23:41:21 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:24511
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S262330AbVGWDlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 23:41:14 -0400
Message-ID: <42E1AE11.5020207@linuxwireless.org>
Date: Fri, 22 Jul 2005 21:40:17 -0500
From: Alejandro Bonilla <abonilla@linuxwireless.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Lee Revell <rlrevell@joe-job.com>, Blaisorblade <blaisorblade@yahoo.it>,
       LKML <linux-kernel@vger.kernel.org>, Andrian Bunk <bunk@stusta.de>,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Giving developers clue how many testers verified certain kernel
 version
References: <200507230244.11338.blaisorblade@yahoo.it>  <42E1986B.8070202@linuxwireless.org> <1122088160.6510.7.camel@mindpipe>  <42E1A832.7010604@linuxwireless.org> <1122088863.6510.19.camel@mindpipe> <Pine.LNX.4.58.0507222029200.6074@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507222029200.6074@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Fri, 22 Jul 2005, Lee Revell wrote:
>  
>
>>Con's interactivity benchmark looks quite promising for finding
>>scheduler related interactivity regressions.
>>    
>>
>
>I doubt that _any_ of the regressions that are user-visible are
>scheduler-related. They all tend to be disk IO issues (bad scheduling or
>just plain bad drivers), and then sometimes just VM misbehaviour.
>
>People are looking at all these RT patches, when the thing is that most
>nobody will ever be able to tell the difference between 10us and 1ms
>latencies unless it causes a skip in audio.
>  
>
True, and I just couldn't agree more with Lee that lots of the delays 
that one looks at is because of user space. Still, I have some doubt on 
how faster 2.6 is sometimes, where 2.4 is faster in other things.

i.e. As my newbie view, I can see 2.6 running faster in X, Compiling and 
stuff, but I see 2.4 working much faster when running commands, response 
and interaction in the console. But then again, this could be only me...


>		Linus
>
>  
>
.Alejandro
