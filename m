Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264270AbUFGD1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264270AbUFGD1v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 23:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264271AbUFGD1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 23:27:51 -0400
Received: from relay01.kbs.net.au ([203.220.32.149]:16285 "EHLO
	relay01.kbs.net.au") by vger.kernel.org with ESMTP id S264270AbUFGD1r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 23:27:47 -0400
Date: Mon, 7 Jun 2004 13:27:44 +1000
From: "Pods" <pods@dodo.com.au>
To: linux-kernel@vger.kernel.org
Reply-to: "Pods" <pods@dodo.com.au>
Subject: Re: lotsa oops - 2.6.5 (preempt + unable handle virutal address + more?)
X-Priority: 3
X-Mailer: Dodo Internet Webmail Server 
X-Original-IP: 203.220.15.86
Content-Transfer-Encoding: 7BIT
X-MSMail-Priority: Medium
Importance: Medium
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <E1BXAnX-0005BG-00@mail.kbs.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok i fixed it. Was a RAM installation problem. I've had trouble with RAM in
this board before. When i initialy set it up, the RAM modules being in 2&3 3
was the only i could get it to boot.

However i had a few more tries and i got a single DIMM bootting the machine
and then i tried two. It didnt boot, so i wirggled it and it work? very
strange. I think the DDR slots may not be up to scratch, but its working...
o rat least, seems to be.

Thanx for your help, even though it wouldnt have been neccessary if i had
taken more care in installing the RAM. *color me red faced*

Thanx again.


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
> 

________________________________________________

Message sent using
Dodo Internet Webmail Server

