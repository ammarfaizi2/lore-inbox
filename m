Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270615AbRHIXhT>; Thu, 9 Aug 2001 19:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270614AbRHIXgd>; Thu, 9 Aug 2001 19:36:33 -0400
Received: from medusa.sparta.lu.se ([194.47.250.193]:25616 "EHLO
	medusa.sparta.lu.se") by vger.kernel.org with ESMTP
	id <S270606AbRHIXf2>; Thu, 9 Aug 2001 19:35:28 -0400
Date: Fri, 10 Aug 2001 00:23:05 +0200 (MET DST)
From: Bjorn Wesen <bjorn@sparta.lu.se>
To: Chris Wilson <jakdaw@lists.jakdaw.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: PS/2 keyboard fails on 2.4.6 and up SMP
In-Reply-To: <20010810001415.038d707b.jakdaw@lists.jakdaw.org>
Message-ID: <Pine.LNX.3.96.1010810002052.9949B-100000@medusa.sparta.lu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Same thing happened to me with 2.4.7 UP, T-bird and KT133A mobo. 

Got the timeouts, and one keystroke every minute got through, mouse was
similarly fscked. Was enough to catch my ctrl+alt+delete fortunately.. and
it worked next time I rebooted. 

I just wrote it off as an AMD/KT133A Linux incompatibility but now it
seems like something else might be responsible...

/Bjorn

On Fri, 10 Aug 2001, Chris Wilson wrote:
>     When I first tried linux 2.4.6 I found that my keyboard failed and I
> could not log into my system - at the time I didn't have time to play so
> just went back to good ole stable 2.2.19 and forgot about it.. I now
> wanted to try 2.4.7-ac10 w. ide, crypto and LVM patches and the same thing
> is happening. One of the bootup messages shows:
> 
> keyboard: Timeout - AT keyboard not present?(ed)
> 
> However the keyboard is certainly present and works under earlier 2.4 and
> 2.2 kernels without any problems. System is a dual PIII-700. Attached are
> gzip'd dmesg and .config's.

