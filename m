Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136132AbRA1AyR>; Sat, 27 Jan 2001 19:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136162AbRA1AyG>; Sat, 27 Jan 2001 19:54:06 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:47376 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S136161AbRA1Axu>; Sat, 27 Jan 2001 19:53:50 -0500
Date: Sat, 27 Jan 2001 21:04:14 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: David Ford <david@linux.com>
cc: Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org
Subject: Re: VM breakdown, 2.4.0 family
In-Reply-To: <3A7357E4.825545E1@linux.com>
Message-ID: <Pine.LNX.4.21.0101272103340.12703-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 27 Jan 2001, David Ford wrote:

> I have Marcelo's patch.  It isn't applicable because I am purposely not enabling any
> swap.  The problem is the system gets down to about 7 megs of buffers free and within
> three seconds has become functionally dead.  Zero response on any user input/output
> device save the magic key.
> 
> The system will then grind the harddrive solid for about 25-30 minutes then
> everything will go silent.
> 
> The brokenness is that the OOM code never activates.

Can you show the result of Alt+SysRq+M when the system is dead?

Thanks

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
