Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129373AbRBUR5o>; Wed, 21 Feb 2001 12:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129512AbRBUR5e>; Wed, 21 Feb 2001 12:57:34 -0500
Received: from chaos.analogic.com ([204.178.40.224]:59264 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129931AbRBUR5Y>; Wed, 21 Feb 2001 12:57:24 -0500
Date: Wed, 21 Feb 2001 12:56:32 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Giuliano Pochini <pochini@shiny.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: 128MB lost... where ?
In-Reply-To: <XFMail.010221182231.pochini@shiny.it>
Message-ID: <Pine.LNX.3.95.1010221125207.15293A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Feb 2001, Giuliano Pochini wrote:

> 
> Perhaps this is a faq...
> I have a dual-800 (mb asus, no AGP) with 1GB ram,
> but according to /proc/meminfo tells I only have
> 900000KB. I tried "mem=1024" boot parameter without
> success. How can I get my 128MB back ?
> 
> 
> Bye.
>     Giuliano Pochini ->)|(<- Shiny Corporation {AS6665} ->)|(<-
> 

You can't. You have to enable HIGHMEM4G in `make config`, then
rebuild the entire kernel. This doesn't work well with 2.4.1 because
many modules will have unresolved symbols. Maybe this has been
fixed in a later kernel.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


