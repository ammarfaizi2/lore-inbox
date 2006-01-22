Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbWAVMNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbWAVMNh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 07:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964778AbWAVMNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 07:13:37 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:53640 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S964777AbWAVMNh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 07:13:37 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Deepak Madhusudan <deepak.katagade@gmail.com>
Subject: Re: Problem in kernel stack size (please help me).
Date: Sun, 22 Jan 2006 14:13:16 +0200
User-Agent: KMail/1.8.2
Cc: Linus Torvalds <torvalds@osdl.org>,
       Suleiman Souhlal <ssouhlal@freebsd.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Al Viro <viro@ftp.linux.org.uk>, Christoph Hellwig <hch@infradead.org>,
       Herbert Poetzl <herbert@13thfloor.at>
References: <6f0f8ee70601220409t63a80180p2a1bdae057f5a7d4@mail.gmail.com>
In-Reply-To: <6f0f8ee70601220409t63a80180p2a1bdae057f5a7d4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601221413.16792.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 January 2006 14:09, Deepak Madhusudan wrote:
> Hi All,
>    I am writing a serialdriver in FED 3 (2.6.9 kernel) which acts as a
> serial interface between the codec and the application. We have
> written an Interrupt Service Routine to handle the interrupts of the
> hardware.The problem what I am facing is: by default FED3(2.6.9) comes
> with the following option enabled in its kernel configuration.
> 
> Processor  type and features ------------>
> [* ] 4GB kernel-space and 4GB user-space virtual memory support.
> 
> If this option is enabled my driver will  get hanged and again I have
> to reboot my system.when I checked the flow of my diver it isgoing up
> to ISR and when the interrupt occurs it is hanging. When I disabled
> the above option and  I recompiled the kernel my driver was able to
> work without any problem.
> 
[snip]
> 
> Since by default in FED3 and FED4 the specified options will come
> enabled I cannot ask the user of my driver to disable the above option
> and to recompile the kernel to use my driver.Please can you help me in
> this regard. I think the problem may be with the kernel stack size.
> please give me the suggestions. waiting for the reply.

Please send us the source of your driver
--
vda
