Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280733AbRKTJOy>; Tue, 20 Nov 2001 04:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280762AbRKTJOd>; Tue, 20 Nov 2001 04:14:33 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:2195 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S280733AbRKTJOX>; Tue, 20 Nov 2001 04:14:23 -0500
Date: Tue, 20 Nov 2001 11:20:37 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: MP FP struct in the EBDA
In-Reply-To: <E1666wX-0000yo-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0111201119390.25946-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2001, Alan Cox wrote:

> > I'd presume this statement isn't true today, e.g. one of the IBM Netfinity
> > boxes here (3500M20) has the MP tables in the EBDA. Also how come we
> > search the whole EBDA (4k)? Whilst the MP 1.4 spec sheet says search the
> > first kilobyte only.
>
> We used to search the last 4K of RAM in the low 640Kb, it looks like that
> was never changed when we began using the EBDA pointer properly.

I'm not sure anyone has a box with the MP tables that high in the EBDA,
but i can vouch for my 3500M20 having it in the 1st k. So should this be
changed to 0x400 to adhere to the specifications?

Regards,
	Zwane Mwaikambo


