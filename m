Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310354AbSCLCfL>; Mon, 11 Mar 2002 21:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310339AbSCLCex>; Mon, 11 Mar 2002 21:34:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65291 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310348AbSCLCei>;
	Mon, 11 Mar 2002 21:34:38 -0500
Message-ID: <3C8D692B.7070508@mandrakesoft.com>
Date: Mon, 11 Mar 2002 21:34:19 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: andersen@codepoet.org, Bill Davidsen <davidsen@tmr.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <Pine.LNX.4.33.0203111810220.8121-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>
>On Mon, 11 Mar 2002, Jeff Garzik wrote:
>
>>You have convinced me that unconditional filtering is bad.  But I still
>>think people should be provided the option to filter if they so desire.
>>
>
>Hey, choice is always good, except if it adds complexity.
>
>The problem with conditional filtering is that either it is a boot (or
>compile time) option, or it is a dynamic filter.
>
heh, I couldn't have given a better argument against a dynamic filter.

I was actually assuming the filter would be a compile-time option, for 
security's sake.  Boot-time option works too.

So, it sounds like you could be sold on an fixed-at-compile-time filter 
that can be disabled at boot :)  I know you don't like 
fixed-at-compile-time as you mentioned, but it's my argument there is a 
class of users that definitely do.  MandrakeSoft would likely enable the 
filter in the "secure" kernel and disable it in the "normal" kernel, for 
example.

    Jeff






