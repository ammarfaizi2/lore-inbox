Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132999AbRDRDyP>; Tue, 17 Apr 2001 23:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133000AbRDRDyF>; Tue, 17 Apr 2001 23:54:05 -0400
Received: from [24.93.67.55] ([24.93.67.55]:33284 "EHLO mail8.triad.rr.com")
	by vger.kernel.org with ESMTP id <S132999AbRDRDxz>;
	Tue, 17 Apr 2001 23:53:55 -0400
Message-ID: <3ADD1067.5090801@triad.rr.com>
Date: Tue, 17 Apr 2001 23:56:23 -0400
From: Ghadi Shayban <ghad@triad.rr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3-ac9 i686; en-US; rv:0.8.1+) Gecko/20010417
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: rw-semaphore regression in 2.4.4-pre4
In-Reply-To: <3ADD07D7.80806@triad.rr.com> <3ADD08B9.EA6D6AD4@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Ghadi Shayban wrote:
> 
>>Processes, most easily mozilla, get stuck in the "D" state in
>>2.4.4-pre4.  I don't believe this was fixed in pre2 but now it happens
>>again.      Also, just a minor error, but 2.4.4-pre4 modules are put in
>>the 2.4.3 directory.  The version number was probably accidentally left
>>the same.
>>
> 
> Linus is good about rememeber to change the version these days.  This
> sounds like a patch/install error on your side...
> 
> --- v2.4.3/linux/Makefile       Thu Mar 29 20:13:15 2001
> +++ linux/Makefile      Fri Apr 13 20:26:46 2001
> @@ -1,7 +1,7 @@
>  VERSION = 2
>  PATCHLEVEL = 4
> -SUBLEVEL = 3
> -EXTRAVERSION =
> +SUBLEVEL = 4
> +EXTRAVERSION =-pre4


I'm very silly.... Let me retest rw-semaphores with the patch "properly" 
applied before I open my mouth.  Sorry for the bother.

Ghadi

