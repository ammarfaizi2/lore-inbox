Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262484AbUCEL3I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 06:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262498AbUCEL3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 06:29:08 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:28873 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262484AbUCEL3D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 06:29:03 -0500
Message-ID: <40485FD0.4000708@cyberone.com.au>
Date: Fri, 05 Mar 2004 22:09:04 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Jason Cox <jpcox@iastate.edu>,
       Autar022@planet.nl
Subject: Re: nicksched v30
References: <4048204E.8000807@cyberone.com.au> <40485B02.4020604@gmx.de>
In-Reply-To: <40485B02.4020604@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Prakash K. Cheemplavam wrote:

> Nick Piggin wrote:
>
>> http://www.kerneltrap.org/~npiggin/v30.gz
>>
>> Applies to kernel 2.6.4-rc1-mm2.
>> Run X at about nice -10 or -15.
>> Please report interactivity problems with the default scheduler
>> before using this one etc etc.
>
>
> So far i noticed:
>
> with default scheduler:
>
> When I run emerge sync (I am on gentoo) and finally the cache on disk 
> gets updated (very heavy disk activity), default scheduler (in 
> conjunction with cfq, haven' tried other) causes a schmall pause of 
> 1-2 seconds when I use my browser, ie mouse cursor is ok, but I cannot 
> scroll for that time.
>

Probably just reading stuff in.

> your scheduler: I tried it with the "love-sources", so maybe that 
> patch "steel300" incorporated was already a bit outdated, but I dunno. 
> It had the same version as above.  When I click on a link in 
> thunderbird and it opens up in firefox (is started and just a new tab 
> is created) the mouses stutters for a brief moment. This didn't happen 
> with default scheduler. I dunno if above sympton happens with yours.
>
> I haven't reniced X withy our patch. But I did it once and I didn't 
> see much of a difference. (I dunno if the mouse stutter went away 
> then...)
>

If you don't renice X then it doesn't get any special treatment and
interactivity is generally worse. It makes a very big difference here
when I run X at -15.

