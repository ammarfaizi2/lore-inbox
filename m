Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292714AbSBZTPb>; Tue, 26 Feb 2002 14:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292718AbSBZTPV>; Tue, 26 Feb 2002 14:15:21 -0500
Received: from pop.gmx.de ([213.165.64.20]:19553 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S292714AbSBZTPE>;
	Tue, 26 Feb 2002 14:15:04 -0500
Message-ID: <3C7BDEA3.672700AB@gmx.net>
Date: Tue, 26 Feb 2002 20:14:43 +0100
From: Gunther Mayer <gunther.mayer@gmx.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linuxdiskcert.org>
CC: Ken Brownfield <brownfld@irridia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] ServerWorks autodma behavior
In-Reply-To: <Pine.LNX.4.10.10202260244170.14807-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:

> Here is the skinny.
>
> Running DOMAIN VALIDATION against the HOST just totally throttles the
> silicon-dma-core.  Basically direct access force the hardware to protect
> itself from pushing the limits of the access, it BLOWS CHUNKS like a
> freshman in college on his/her first drunk.
>
> If you run the it top down via block, the mainloop eases alot of the
> pressure.  The punch line is like this .........
>
> DV(BLOWS CHUNKS) == Block_pressure(BLOWS CHUNKS)

>
>
> If DV fails, you have not got a prayer of believing the physical is
> stable, IMHO.

Does this mean the ServerWorks IDE chipset is buggy ?

