Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284979AbRL3VAE>; Sun, 30 Dec 2001 16:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284987AbRL3U7y>; Sun, 30 Dec 2001 15:59:54 -0500
Received: from dial-up-2.energonet.ru ([195.16.109.101]:6784 "EHLO
	dial-up-2.energonet.ru") by vger.kernel.org with ESMTP
	id <S284979AbRL3U7p>; Sun, 30 Dec 2001 15:59:45 -0500
Date: Mon, 31 Dec 2001 00:01:09 +0000 (GMT)
From: ertzog <ertzog@bk.ru>
To: Lennert Buytenhek <buytenh@gnu.org>
cc: linux-kernel@vger.kernel.org, jdike@karaya.com
Subject: Re: [PATCH][RFC] global errno considered harmful
In-Reply-To: <20011230110623.A17083@gnu.org>
Message-ID: <Pine.LNX.4.21.0112302355100.1013-100000@dial-up-2.energonet.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


And can anybody explain, why is it so ?
(I mean checking for -1, and the switch(errno){}.)
AFAIK, syscall returns us a number (on i386 it is in eax)
and we can use it. Is errno a kernel thing, or GLIBC ?
Haven't we a return code in eax, after   int 0x80 ?  
(sorry, but I never worked on Linux on other architectures)  


 
Best regards.

On Sun, 30 Dec 2001, Lennert Buytenhek wrote:
> Is there any particular reason we need a global errno in the kernel
> at all? (which, by the way, doesn't seem to be subject to any kind of

