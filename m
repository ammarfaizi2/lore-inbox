Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292958AbSBVTaN>; Fri, 22 Feb 2002 14:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292960AbSBVTaD>; Fri, 22 Feb 2002 14:30:03 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:5760 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S292958AbSBVT3r>; Fri, 22 Feb 2002 14:29:47 -0500
Date: Fri, 22 Feb 2002 12:42:02 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: David Mosberger <davidm@hpl.hp.com>
Cc: Steffen Persvold <sp@scali.com>, linux-kernel@vger.kernel.org,
        jmerkey@timpanogas.org
Subject: Re: ioremap()/PCI sickness in 2.4.18-rc2 (FIXED ALMOST)
Message-ID: <20020222124202.A725@vger.timpanogas.org>
In-Reply-To: <20020220103320.A32211@vger.timpanogas.org> <20020220103539.B32211@vger.timpanogas.org> <3C73DC34.E83CCD35@mandrakesoft.com> <20020220.093034.112623671.davem@redhat.com> <20020220110004.A32431@vger.timpanogas.org> <20020220145449.A1102@vger.timpanogas.org> <20020220151053.A1198@vger.timpanogas.org> <3C7626A9.330A9249@scali.com> <20020222111756.A11081@vger.timpanogas.org> <15478.37161.767510.748999@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15478.37161.767510.748999@napali.hpl.hp.com>; from davidm@hpl.hp.com on Fri, Feb 22, 2002 at 10:42:49AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2002 at 10:42:49AM -0800, David Mosberger wrote:
> >>>>> On Fri, 22 Feb 2002 11:17:56 -0700, "Jeff V. Merkey" <jmerkey@vger.timpanogas.org> said:
> 
>   Jeff> On early IA64 long long was assumed to be 64 bit, long 32
>   Jeff> bit. After emailing some folks off line I relaize this may not
>   Jeff> be the case any longer, but still is on some compiler options.
> 
> In the context of Linux, this is certainly not true.  Linux/ia64
> always has been LP64 (i.e., sizeof(long)=8).  Perhaps you're confusing
> this with the hp-ux C compiler, which defaults to ILP32?  Another

Correct.

Jeff

> potential source of confusion is Windows, which uses the P64 data
> model (only pointers and "long long" are 64 bits).
> 
> 	--david
