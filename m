Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286758AbSBRUQu>; Mon, 18 Feb 2002 15:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286311AbSBRUQl>; Mon, 18 Feb 2002 15:16:41 -0500
Received: from chaos.analogic.com ([204.178.40.224]:51329 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S285417AbSBRUQg>; Mon, 18 Feb 2002 15:16:36 -0500
Date: Mon, 18 Feb 2002 15:19:31 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Nix N. Nix" <nix@go-nix.ca>
cc: acme@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: Non-root IPX
In-Reply-To: <1013922173.20865.12.camel@tux>
Message-ID: <Pine.LNX.3.95.1020218151516.21701C-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Feb 2002, Nix N. Nix wrote:

> 
> >From Transgaming (makers of WineX):
> 
> > The problem is not WineX, it's the Linux kernel, it only allows root 
> > to create IPX sockets. Probably something to do with security, but I 
> > don't know what.
> 
> Is this true ?  If so, what can I do to allow regular users to make IPX
> sockets ?  Is that a wise thing to do ?  I'm interested in running a
> Windows game (Starcraft) as a normal user.  WineX has gotten to the
> point where that is possible, minus IPX.
> 
> 
> Thanks for your help.
> 

Normal users can create and use IPX sockets. They just can't make
'servers'. If normal users need to make servers, make the executible
suid,  get the code root privs for an instant, then revert
back. Warning. A network server of any kind can be exploited. At
the very least, it can be used for DOS attacks.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


