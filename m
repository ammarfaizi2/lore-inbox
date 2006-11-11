Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424194AbWKKQBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424194AbWKKQBr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 11:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424118AbWKKQBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 11:01:46 -0500
Received: from mail1.key-systems.net ([81.3.43.253]:54459 "HELO
	mailer2-1.key-systems.net") by vger.kernel.org with SMTP
	id S1424194AbWKKQBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 11:01:46 -0500
Message-ID: <4555F3E3.4020909@scientia.net>
Date: Sat, 11 Nov 2006 17:01:39 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Roger Heflin <rheflin@atipa.com>, linux-kernel@vger.kernel.org
Subject: Re: Strange write errors on FAT32 partition (maybe an FAT32 bug?!)
References: <4550A481.2010408@scientia.net>	 <87psbzrss2.fsf@duaron.myhome.or.jp> <4553744E.3050007@scientia.net>	 <45539188.5080607@atipa.com> <45539366.7070809@scientia.net>	 <45539588.7020504@atipa.com> <45539699.40105@scientia.net>	 <45539753.7060906@atipa.com> <4553A461.4080002@scientia.net>	 <4553A57C.5070503@atipa.com>  <4553A6C9.4010906@scientia.net> <1163154536.7900.23.camel@localhost.localdomain>
In-Reply-To: <1163154536.7900.23.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> If it was a PCI side parity error yes. If you have dodgy memory then the
> K8 will MCE and report that if the MCE code is loaded. If the memory is
> non ECC or the CPU doesn't support ECC memory you'll get silent strange
> behaviour, but a long run of memtest86 can usually find any main memory
> problems.
>
> Alan
>   
Dear Alan....
The memory has ECC (and neither EDAC_MC with K8 support, nor mcelog (I 
even tried to compile in both the AMD and intel MCE support) nor memtest 
does show me any errors.

Pleas have a look at my "new" post.... as this is definitely not FAT32 
related,.. I posted the whole thing unter a new thread (that that would 
be the correct way).
There you'll also find my latest results.

Thanks in advance for any further help :-)

Chris.
