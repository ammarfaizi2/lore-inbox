Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264251AbUFGAFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264251AbUFGAFY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 20:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264253AbUFGAFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 20:05:24 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:4809 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S264251AbUFGAFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 20:05:18 -0400
Message-ID: <40C3B22D.8080308@elegant-software.com>
Date: Sun, 06 Jun 2004 20:09:17 -0400
From: Russell Leighton <russ@elegant-software.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: arjanv@redhat.com
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Using getpid() often, another way? [was Re: clone() <->	getpid()
 bug in 2.6?]
References: <40C1E6A9.3010307@elegant-software.com>	 <Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org>	 <40C32A44.6050101@elegant-software.com>	 <40C33A84.4060405@elegant-software.com> <1086537490.3041.2.camel@laptop.fenrus.com>
In-Reply-To: <1086537490.3041.2.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>On Sun, 2004-06-06 at 17:38, Russell Leighton wrote:
>  
>
>>I have a library that creates 2 threads using clone().
>>[NOTE: I can't use pthreads for a variety of reasons, mostly due
>>to the wacky signal handling rules...it turns out that using clone() is 
>>cleaner for me anyway.]
>>    
>>
>
>a library using clone sounds suspect to me, I can't imagine an app using
>pthreads being able to just use your library as a result.
>
Why? In  what way would a program that uses pthreads interfere with 
threads created using clone()?
