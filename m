Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262927AbUFFGAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbUFFGAi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 02:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262951AbUFFGAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 02:00:38 -0400
Received: from relay01.kbs.net.au ([203.220.32.149]:57242 "EHLO
	relay01.kbs.net.au") by vger.kernel.org with ESMTP id S262927AbUFFGAe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 02:00:34 -0400
Date: Sun, 6 Jun 2004 16:00:32 +1000
From: "Pods" <pods@dodo.com.au>
To: linux-kernel@vger.kernel.org
Reply-to: "Pods" <pods@dodo.com.au>
Subject: Re: lotsa oops - 2.6.5 (preempt + unable handle virutal address + more?)
X-Priority: 3
X-Mailer: Dodo Internet Webmail Server 
X-Original-IP: 203.221.30.76
Content-Transfer-Encoding: 7BIT
X-MSMail-Priority: Medium
Importance: Medium
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <E1BWqhq-0004wj-00@mail.kbs.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i'll get to your suggestions soon, infact the RAM was my next plan of
attack. But meanwhile, why dont you have a look at some new oops output from
a new kernel with lots of debug info turned on.

http://users.quickfox.org/~pods/linux-issues/kernel-debug-oops.txt


--------- Original Message --------
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Pods <pods@dodo.com.au>, linux-kernel@vger.kernel.org
<linux-kernel@vger.kernel.org>
Subject: Re: lotsa oops - 2.6.5 (preempt + unable handle virutal address +
more?)
Date: 06/06/04 05:28

>
> On Saturday 05 June 2004 18:27, Pods wrote:
> &gt; &gt;&gt; Run memtest86
> &gt; Tried once before, didnt boot... died :( memtest page says this
happens on
> &gt; some hardware and they're not sure why.
>
> Ho hum. Looks like good starting point to debug.
> Remove RAM until you have &lt;= 2 GB, then run memtest86
> (or modified versions of it with debug prints)
> until you know where it dies.
>
> &gt; &gt;&gt; Underclock your system
> &gt; its not over clocked :/
>
> I mean, underclock below normal conditions.
>
> &gt; &gt;&gt; lower IDE DMA mode and see whether it stops oopsing.
> &gt;
> &gt; tried setting dma = off in hdparm, didnt work, still got crashes
compiling
> &gt; firebird.. infact, it didnt even get passed the ./configure stage :(
>
> Use hdparm to set, say, udma0.
>
> &gt; Each time (just about, didnt do it once out of 6ish times) i set the
dma to
> &gt; off (either at boot or runtime) i got a &quot;spurious 8259A
interript: IRQ 7&quot;..
> &gt; apparantly, iirc that debug message has been taken out of 2.6.6
>
> I have 'em too. Not a real issue on lots of systems.
>
> &gt; Please guys, CC me your responces, otherwise i have to look at some
> &gt; archives, and reply via webmail... it took 2 firefox crashes (one of
which
> &gt; brought down X) to just right this message... now im going to take a
chance
> &gt; and hit the submit
> &gt; button
> --
> vda
>
>
>
>
>
>
>
>
>
>
> 

________________________________________________

Message sent using
Dodo Internet Webmail Server

