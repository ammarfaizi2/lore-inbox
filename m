Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316782AbSGVLVZ>; Mon, 22 Jul 2002 07:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316755AbSGVLUZ>; Mon, 22 Jul 2002 07:20:25 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:18173 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316821AbSGVLTj>; Mon, 22 Jul 2002 07:19:39 -0400
Subject: Re: ECS DeskNote A929 (i-Buddie XP)  (Kernel 2.4.18 & 2.4.19rc3)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Humphreys <dave@datatone.co.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <96AD56B9964DC448990E3DE3FD19A65605039C@d21.datatone.co.uk>
References: <96AD56B9964DC448990E3DE3FD19A65605039C@d21.datatone.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 22 Jul 2002 13:35:18 +0100
Message-Id: <1027341318.31787.11.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-22 at 10:29, Dave Humphreys wrote:
> I have just aquired an ECS DeskNote A929 (i-Buddie XP). This
> machine is supposed to be based on:
> SiS 740 North Bridge
> SiS 961 South Bridge
> with integrated network interface (and graphics and other features).
> 
> I found that I could not make the kernel detect the network
> card, despite the fact that I had built support for 'SiS 900/7096'
> into the kernel.
> 
> I found a patch which identified a need to add the SiS 740 and
> SiS 961 into pci.ids, and which suggested that this was all that was
> necessary to make the 740/961 work.
> 
> I find that my kernel does not create /proc/pci which suggests
> to me something quite fundamental.
> 
> I ran lspci -H2 and I get:
> 
> 00:04.0 Class 000e: 00c1:0000
> 00:08.0 Class 000e: 00c1:0000
> 00:0c.0 Class 0000: 0040:0000 
> 
> The 0000 class code worries me, as do the vendor and device ID's.
> 
> The machine came with a 'ThizLinux' CD which has 2.4.18 kernel,
> so someone has made it work, but I don't have the sources.

The GPL license requires they provide you the sources to the GPL'd code
at cost. If they fail to do so they are violating copyright law.


