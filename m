Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314634AbSHIQx4>; Fri, 9 Aug 2002 12:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314938AbSHIQx4>; Fri, 9 Aug 2002 12:53:56 -0400
Received: from mail-out2.apple.com ([17.254.0.51]:11742 "EHLO
	mail-out2.apple.com") by vger.kernel.org with ESMTP
	id <S314680AbSHIQxz>; Fri, 9 Aug 2002 12:53:55 -0400
Message-ID: <3D53F478.8010405@nighton.net>
Date: Fri, 09 Aug 2002 09:57:28 -0700
From: David Love <dlove@nighton.net>
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ed Wang <ice_tea_4_u@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: A simple question
References: <20020809012606.11037.qmail@web21106.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ed Wang wrote:
> I saw a lot of function define as _inline_ in Linux
> kernel.  What does the term _inline_  mean?  For the
> assembly inline statement, _asm_ should do the work.
> 
> Thanks for the help!
> 
> Ed 
> 


Feel free to correct me if I'm wrong...

 From my understanding, inline has asolutely nothing to do with 
assembly.  When a function is declared as inline, you're basically 
telling the compiler that anytime it runs into this function being 
called, to replace that call with the body of the function (to eliminate 
the overhead of making the function call).  It's great for small, little 
operations that are done extremely often.

-D.Love



