Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132852AbRDUTZp>; Sat, 21 Apr 2001 15:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132847AbRDUTZf>; Sat, 21 Apr 2001 15:25:35 -0400
Received: from imap.digitalme.com ([193.97.97.75]:16263 "EHLO digitalme.com")
	by vger.kernel.org with ESMTP id <S132846AbRDUTZZ>;
	Sat, 21 Apr 2001 15:25:25 -0400
Message-ID: <3AE1DE3F.5000101@bigfoot.com>
Date: Sat, 21 Apr 2001 15:23:43 -0400
From: "Trever L. Adams" <trever_Adams@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3 i686; en-US; rv:0.8.1+) Gecko/20010421
X-Accept-Language: en
MIME-Version: 1.0
To: Juri Haberland <juri@koschikode.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Crash: XFree86 4.0.3 and Kernel 4.0.3
In-Reply-To: <20010421180845.18802.qmail@babel.spoiled.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juri Haberland wrote:

> 
> Hi Trevor,
> 
> I have the same problem with almost the same combination (RH 7.0 instead of
> RH 7.1). Did you compile the XFree server yourself and if so, did you
> optimize it for i686? The reason why I'm asking is that I did that and
> suspected the optimazions to cause the crashes.
> 
> Juri
> 
> 

Juri, et al.

    I did some searches on google.  It seems that it is the combination 
of kernel 2.4, glibc2.2.x, and possibly the i686 optimizations.  I found 
my machine was alive from a network connection.  The problem is, I cant 
get my keyboard back even with sysrq (syslog does show it changing into 
XLATE mode... I thought alt-ctrl-r was raw?).  Of course the machine was 
alive, but X was dead. xscreensaver and the screen save it ran along 
with most of the desktop stuff was still running.

  Anyway, I tried 'shutdown -r now'over the network. Didn't work.  I had 
to do a hard reset.  So it seems the kernel may be slightly left in an 
unknown or confused state.

I did not compile it myself.  Using RedHat 7.1 standard.

Since I saw this mentioned here recently, does gcc still think 686=cmov? 
If so, Alan or someone else, does Athlon classic (slot 800 Mhz) support 
cmov?

Trever Adams

