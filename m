Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267502AbSLLWNb>; Thu, 12 Dec 2002 17:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267509AbSLLWNb>; Thu, 12 Dec 2002 17:13:31 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:5019 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S267502AbSLLWNa>;
	Thu, 12 Dec 2002 17:13:30 -0500
Message-ID: <3DF90BDE.3070802@namesys.com>
Date: Fri, 13 Dec 2002 01:21:18 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: wz6b@arrl.net
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: More progress on loading 2.5.50
References: <200212121351.50151.wz6b@arrl.net>
In-Reply-To: <200212121351.50151.wz6b@arrl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Young wrote:

>PSAUX is not some fantastic French technology, it must be enabled.
>
;-)

>
>My 3COM/USB adapter seems to be enabled correctly but the LCD lights do not 
>blink. Still testing.
>
>95% there, although I did hack into do_mounts and force fed the proper root 
>device.
>
>The patch for make that fixes make modules works fine, thank you.
>
>
>Question:  Can I turn REISERFS on and off for testing
>
yes, though you'll also need to mkreiserfs your hard drive which has the 
pleasing effect of removing and destroying ext2 and all files stored in 
it.... (try man mkreiserfs)

> (does in nun on top of 
>EXT2)
>
Au contraire, I must say that the ext2 developers are definitely better 
nuns than we are.

>
>Yast is a dog.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>
I think you should use 2.4.20 not 2.5.50.  Really, the unstable series 
(2.5) is not for  people to use, it is for people to test.

