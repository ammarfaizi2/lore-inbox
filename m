Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263141AbREaSS3>; Thu, 31 May 2001 14:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263142AbREaSST>; Thu, 31 May 2001 14:18:19 -0400
Received: from mail1.netcabo.pt ([212.113.161.135]:21775 "EHLO netcabo.pt")
	by vger.kernel.org with ESMTP id <S263141AbREaSSC>;
	Thu, 31 May 2001 14:18:02 -0400
Message-ID: <3B168B59.70906@europe.com>
Date: Thu, 31 May 2001 19:20:09 +0100
From: Vasco Figueira <figueira@europe.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5 i686; en-US; rv:0.9+) Gecko/20010530
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] reclaim dirty dead swapcache pages
In-Reply-To: <Pine.LNX.4.21.0105301729080.5231-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Marcelo Tosatti wrote:

> I tested it and yes, it works. 
(...)
> Please test. 

I've tested it against vanilla 2.4.5 and it resolves the freeze problem, 
though:

I've opened x, gnome, mozilla, mozilla -mail, 3 gnome-terminals, pan, 
xmms, some files and javac. Swap was totally filled up and it didn't 
froze (good!). However suddently it came very busy (i thougth it was 
going to freeze again), the music stopped, and came back to normal 
again. It had killed xmms, I noticed after.

Is it intentional to kill processes? Well, it does reolve the problem, 
but kills some processes, probably the most eager ones. I will keep 
using this patch and report again if something relevant is found.

So far, so good, this is better tha having to swapoff & swapon all the 
time. Nice work Marcelo.
-- 
Regards,
                             Vasco Figueira

http://students.fct.unl.pt/users/vaf12086/

