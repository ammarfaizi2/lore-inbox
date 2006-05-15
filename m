Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbWEOSu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWEOSu3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 14:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWEOSu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 14:50:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56457 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932106AbWEOSu1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 14:50:27 -0400
Date: Mon, 15 May 2006 11:53:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: 2.6.17-rc4-mm1
Message-Id: <20060515115302.5abe7e7e.akpm@osdl.org>
In-Reply-To: <6bffcb0e0605151137v25496700k39b15a40fa02a375@mail.gmail.com>
References: <20060515005637.00b54560.akpm@osdl.org>
	<6bffcb0e0605151137v25496700k39b15a40fa02a375@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:
>
> Hi,
> 
> On 15/05/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc4/2.6.17-rc4-mm1/
> >
> 
> When I try to "modprobe -r i2c_i801" modprobe hangs
> 
> [michal@ltg01-fedora ~]$ ps aux | grep mod
> root      5943  0.0  0.0   1648   432 tty1     D+   20:15   0:00
> modprobe -r i2c_i801
> michal   15499  0.0  0.0   1836   496 pts/4    S+   20:33   0:00 grep mod
> 
> Here is strace log
> http://www.stardust.webpages.pl/files/mm/2.6.17-rc4-mm1/strace.txt
> Here is config http://www.stardust.webpages.pl/files/mm/2.6.17-rc4-mm1/mm-config
> 
> 2.6.17-rc3-mm1 was fine. I don't see nothing abnormal in dmesg.
> 

Are you able to get a sysrq-P and/or sysrq-T trace out of it?
