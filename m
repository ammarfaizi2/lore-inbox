Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277124AbRJDEsj>; Thu, 4 Oct 2001 00:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277125AbRJDEsa>; Thu, 4 Oct 2001 00:48:30 -0400
Received: from mx2.fuse.net ([216.68.1.120]:49120 "EHLO mta02.fuse.net")
	by vger.kernel.org with ESMTP id <S277124AbRJDEsQ>;
	Thu, 4 Oct 2001 00:48:16 -0400
Message-ID: <3BBBEA1E.8060304@fuse.net>
Date: Thu, 04 Oct 2001 00:48:30 -0400
From: Nathan <wfilardo@fuse.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011001
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10 hangs on console switch
In-Reply-To: <E15oURs-0005XB-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>>You are using the Nvidia drivers aren't you. They seem to have timing
>>>dependant screen mode switch problems. The timing has changed in 2.4.10
>>>
>>Not the nvidia supplied drivers. I am using the nvidia driver (nv)  that
>>comes with XFree86 4.1.0. I did not compile in kernel agpgart and driver
>>support.
>>
>
>I'm seeing  reports of this one always with nvidia cards and with both sets
>of Nvidia drivers - I guess they both do the same thing and have the same
>bug, or the user mode XFree bit is in both cases doing it.
>
>Right now thats all I can really point at as a pattern, I dont know why the
>problem should be there
>
>Alan
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
Don't have that problem here [least, haven't run into it yet].  I'm 
currently running 2.4.10+RML's preempt and net entropy patches, system 
is a VIA chipset Athlon 900Mhz with nVidia's proprietary drivers and a 
GeForce2 GTS 64MB.  Help shed any light on the issue?

--Nathan



