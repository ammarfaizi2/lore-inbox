Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129875AbQJ3Xxs>; Mon, 30 Oct 2000 18:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129874AbQJ3Xxj>; Mon, 30 Oct 2000 18:53:39 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:65287 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129416AbQJ3Xx0>; Mon, 30 Oct 2000 18:53:26 -0500
Message-ID: <39FE090E.A3AC48F3@timpanogas.org>
Date: Mon, 30 Oct 2000 16:49:34 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Ingo Molnar <mingo@elte.hu>,
        "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <Pine.LNX.4.21.0010302325240.16101-100000@imladris.demon.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David/Alan,

Andre Hedrick is now the CTO of TRG and Chief Scientist over Linux
Development.  After talking 
to him, we are going to do our own ring 0 2.4 and 2.2.x code bases for
the MANOS merge.  
the uClinux is interesting, but I agree is limited.  

MANOS schedules should be unaffected.  The current DLL prototype of
Linux 2.2 is ring 0, but I shudder at trying to merge all the changes
I've done to it into core 2.2.X as a .config
option.  There's also the gravity well forces of different views to this
effort.  With Andre 
on the job, I am more confident in co-opting the Linux drivers and just
biting the bullet 
on the support issues, and doing a full fork of Linux.

Jeff

David Woodhouse wrote:
> 
> On Mon, 30 Oct 2000, Ingo Molnar wrote:
> 
> > On Mon, 30 Oct 2000, Jeff V. Merkey wrote:
> >
> > > Is there an option to map Linux into a flat address space [...]
> >
> > nope, Linux is fundamentally multitasked.
> 
> uClinux may be able to do this, at the cost of a dramatically reduced
> userspace functionality.
> 
> --
> dwmw2
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
