Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262665AbVCWO5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbVCWO5j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 09:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbVCWO5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 09:57:39 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:50387 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262665AbVCWOwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 09:52:44 -0500
Date: Wed, 23 Mar 2005 15:52:39 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: sounak chakraborty <sounakrin@yahoo.co.in>
cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: error while implementing kill()
In-Reply-To: <20050323140803.15895.qmail@web53308.mail.yahoo.com>
Message-ID: <Pine.LNX.4.61.0503231548450.10048@yvahk01.tjqt.qr>
References: <20050323140803.15895.qmail@web53308.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>dear sir,
> I am unable to use the system call kill(pid,sig).I
>have included the header file <signal.h>. I used it in
>a module to kill a process. The module is compiling
>properly but giving the following error while
>inserting the module,
>   unresolved symbol kill()

Who says that kill() is
1) a defined function
2) is the function that does what the libc call does
3) is the function that does what you expect

As for sending signals,
it's been posted today already, see the archives.
http://marc.theaimsgroup.com/?l=linux-kernel&m=111155537319322&w=2


Jan Engelhardt
-- 
