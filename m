Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313114AbSEVMpF>; Wed, 22 May 2002 08:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313122AbSEVMpE>; Wed, 22 May 2002 08:45:04 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61199 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313114AbSEVMpE>; Wed, 22 May 2002 08:45:04 -0400
Subject: Re: [PATCH] 2.5.17 /dev/ports
To: davem@redhat.com (David S. Miller)
Date: Wed, 22 May 2002 14:05:00 +0100 (BST)
Cc: paulus@samba.org, dalecki@evision-ventures.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020522.035435.68675894.davem@redhat.com> from "David S. Miller" at May 22, 2002 03:54:35 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17AVnY-0001YZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    From: Paul Mackerras <paulus@samba.org>
>    Date: Wed, 22 May 2002 20:42:47 +1000 (EST)
> 
>    Martin Dalecki writes:
>    
>    > Remove support for /dev/port altogether.
>    
>    Great idea!
>    
> You have my blessing too :-)

I'd rather you didn't break too much application code. How do you think the
perl people and the python folks do hardware control ? Or for that matter
java people trying to avoid the crawling horrors of JNI. Its also used by
libraries like libieee1284. Clock(8) uses it on some systems if the 
/dev/rtc isn't available or built in.

Xfree86 much to my suprise seems completely clean. Non Linux stuff uses it
extensively but not Linux.

ALan
