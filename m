Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289880AbSBZPLx>; Tue, 26 Feb 2002 10:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288800AbSBZPJo>; Tue, 26 Feb 2002 10:09:44 -0500
Received: from chaos.analogic.com ([204.178.40.224]:63626 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S288830AbSBZPJW>; Tue, 26 Feb 2002 10:09:22 -0500
Date: Tue, 26 Feb 2002 10:11:21 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Guido Volpi <lugburz@tiscalinet.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: oproblem with nvidia driver
In-Reply-To: <200202261447.g1QElLO02468@localhost.localdomain>
Message-ID: <Pine.LNX.3.95.1020226100558.3017B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2002, Guido Volpi wrote:

> it's all right: nvidia modules depend only by nvidia, but i don't understand 
> why a module that is perfect (or so) with 2.4.17 in 2.4.18-rc4 is no more 
> usabily.
> 

Because the internal structure of the kernel changed. The kernel
developers are always changing the INTERNAL kernel stuff, hopefully
to improve performance. The only promise between kernel versions
is that the EXTERNAL stuff won't change, i.e., the API. But, even
this sometimes changes, things like the stuff in /proc.

So, if you are going to install a different kernel major version
number, you are going to need compatible third-party drivers and
sometimes, even new tools to compile the kernel.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

        111,111,111 * 111,111,111 = 12,345,678,987,654,321

