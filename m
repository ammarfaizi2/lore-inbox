Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266846AbUBMJar (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 04:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266852AbUBMJar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 04:30:47 -0500
Received: from main.gmane.org ([80.91.224.249]:6534 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266846AbUBMJaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 04:30:46 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Simon Oosthoek <simon@ti-wmc.nl>
Subject: Re: Problem EIP + kernel panic
Date: Fri, 13 Feb 2004 10:28:20 +0100
Message-ID: <c0i5bk$src$1@sea.gmane.org>
References: <200402120105.33222.egan@club-internet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: darla.ti-wmc.nl
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
In-Reply-To: <200402120105.33222.egan@club-internet.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Emmanuel Gaudin wrote:
> Hi everybody , and sorry for my english.
> 
> I am under debian sid and i have installed the kernel 2.424 . After few time i 
> noticed that the new kernel-image on the debian apt tree was available. So i 
> decidede to install it. (For the 2.4.24 i did with the kernel sources and 
> make dep etc..) I have installed it then i reboot.
> On the reboot i have a kernel panic due to a eip problem.
> My mother board is a p4p800 and the kernel version i've installed is the 
> 2.6.2-smp. (i have a 2.6 ghz intel cpu with hyperthreading.) 
> 
> Have someone an idea? 

Try booting with kernel parameter pnpbios=off, it's a problem with the 
pnp implementation of the intel 8(6?/7)5 chipset. (a bios upgrade to P18 
didn't help for me, I don't know if recent changes in 2.6.3-... address 
this issue)

I may not be the best person to answer this, I just know this is the 
problem ;-)

Cheers

Simon

