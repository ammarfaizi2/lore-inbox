Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136974AbREJWje>; Thu, 10 May 2001 18:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136975AbREJWjZ>; Thu, 10 May 2001 18:39:25 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:10259 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136974AbREJWjM>; Thu, 10 May 2001 18:39:12 -0400
To: linux-kernel@vger.kernel.org
From: hpa@transmeta.com (H. Peter Anvin)
Subject: Re: Not a typewriter
Date: 10 May 2001 15:38:32 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9df598$8d1$1@tazenda.transmeta.com>
In-Reply-To: <Pine.LNX.3.95.1010510173138.29690A-100000@chaos.analogic.com>
Reply-To: hpa@transmeta.com (H. Peter Anvin)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.3.95.1010510173138.29690A-100000@chaos.analogic.com>
By author:    "Richard B. Johnson" <root@chaos.analogic.com>
In newsgroup: linux.dev.kernel
> 
> I noticed that my favorite "errno" has now gotten trashed by
> the newer 'C' runtime libraries.
> 
> ENOTTY has been for ages, "Not a typewriter".
> It's now been changed to "Inappropriate ioctl for device".
> 
> Methinks that this means that ../linux/include/asm/errno.h now needs
> to be updated:
> 
> 
> -#define	ENOTTY		25	/* Not a typewriter */
> +#define	ENOTTY		25	/* Inappropriate ioctl for device 
> */
> 
> None of these strings are in the kernel, but the headers probably should
> show the "latest standard".
> 

Sounds like someone has just clarified what the heck it means.  "tty"
and "typewriter" aren't exactly the same thing (even though "tty"
stands for "teletypewriter" it has come to mean something completely
different in a Unix context)... "not a typewriter" is just a
completely confusing error message for the uninitiated.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
