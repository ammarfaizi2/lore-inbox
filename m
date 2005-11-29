Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbVK2QLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbVK2QLL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 11:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbVK2QLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 11:11:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39561 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751395AbVK2QLI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 11:11:08 -0500
Date: Tue, 29 Nov 2005 08:10:58 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Michael Krufky <mkrufky@m1k.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc3
In-Reply-To: <438C0124.3030700@m1k.net>
Message-ID: <Pine.LNX.4.64.0511290808510.3177@g5.osdl.org>
References: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org> <438C0124.3030700@m1k.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 29 Nov 2005, Michael Krufky wrote:
>  
> Those memory problems affecting v4l/dvb seem to be fixed (for me) , and
> everything seems to work, but I got this oops on bootup.  This is the first
> 2.6.15-rcX kernel that I've installed on this particular box.  2.6.14 worked
> fine.

Ok, Nick's obviously correct patch fixed that, but now I wonder what the 
_heck_ your bootup process does:

> Process gdb (pid: 5628, threadinfo=f488e000 task=f7239a30)

what kind of _strange_ boot process has gdb in it? 

Morbidly curious,

		Linus
