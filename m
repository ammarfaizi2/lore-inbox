Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267581AbTAXHjO>; Fri, 24 Jan 2003 02:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267578AbTAXHjO>; Fri, 24 Jan 2003 02:39:14 -0500
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:26353 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S267581AbTAXHjN>; Fri, 24 Jan 2003 02:39:13 -0500
Message-ID: <3E30F0FC.1010008@ToughGuy.net>
Date: Fri, 24 Jan 2003 13:23:32 +0530
From: Linux Geek <bourne@ToughGuy.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Madhavi <madhavis@sasken.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Stack overflow
References: <Pine.LNX.4.33.0301241232590.3655-100000@pcz-madhavis.sasken.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>I have a functionality which works well if the code whcih performs this
>function is embedded in the required function. If this functionality is
>implemented as a separate function, and this function is called at the
>required place, the system crashes. I have used KDB for debugging. But,
>  
>
    I'd suggest check the args passed to the function and the sizes they 
would consume when they are passed as 'call by value'.
Try to pass them as pointers maybe.

Yes, i think there is a limit on kernel stack but not i'm not too sure 
about the number.

