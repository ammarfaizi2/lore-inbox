Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283736AbRK3UmX>; Fri, 30 Nov 2001 15:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283791AbRK3UmO>; Fri, 30 Nov 2001 15:42:14 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10256 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S283736AbRK3UmG>; Fri, 30 Nov 2001 15:42:06 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Coding style - a non-issue
Date: 30 Nov 2001 12:41:34 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9u8qtu$u2b$1@cesium.transmeta.com>
In-Reply-To: <OF8451D8AC.A8591425-ON4A256B12.00806245@au.ibm.com> <3C07CCCD.EA5E340A@randomlogic.com> <3C07D669.6C234598@mandrakesoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3C07D669.6C234598@mandrakesoft.com>
By author:    Jeff Garzik <jgarzik@mandrakesoft.com>
In newsgroup: linux.dev.kernel
>
> "Paul G. Allen" wrote:
> > IMEO, there is but one source as reference for coding style: A book by
> > the name of "Code Complete". (Sorry, I can't remember the author and I
> > no longer have a copy. Maybe my Brother will chime in here and fill in
> > the blanks since he still has his copy.)
> 
> Hungarian notation???
> 
> That was developed by programmers with apparently no skill to
> see/remember how a variable is defined.  IMHO in the Linux community
> it's widely considered one of the worst coding styles possible.
> 

Indeed.  What can you say for a technique which basically promotes
*reducing* abstraction and information hiding?

There is a reason why the Win64 ABI uses the same "int" and "long" as
Win32... (both are 32 bits.)  They added meaningless abstractions, and
didn't add abstractions where they needed to...

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
