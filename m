Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273240AbRINEEP>; Fri, 14 Sep 2001 00:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273277AbRINEEF>; Fri, 14 Sep 2001 00:04:05 -0400
Received: from b0rked.dhs.org ([216.99.196.11]:54403 "HELO b0rked.dhs.org")
	by vger.kernel.org with SMTP id <S273240AbRINEDw>;
	Fri, 14 Sep 2001 00:03:52 -0400
Date: Thu, 13 Sep 2001 21:02:57 -0700 (PDT)
From: Chris Vandomelen <chrisv@b0rked.dhs.org>
X-X-Sender: <chrisv@linux.local>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Athlon bug stomping #2
In-Reply-To: <Pine.GSO.4.21.0109132350420.24762-100000@jacui>
Message-ID: <Pine.LNX.4.31.0109132101210.10262-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 13 Sep 2001, VDA wrote:
>
> > Device 0 Offset 55 - Debug (RW)
> > 7-0 Reserved (do not program). default = 0
> > *** 3R BIOS: non-zero!?
> > *** YH BIOS: zero.
> > *** TODO: try to set to 0.
>
> I tryed sequentially to test the values given. It only worked when I set
> offset 0x55 to 0, and then stopped. I don't need to set any other value in
> other addresses. This is enough.
>
> It's weird when your system only works when changing a "do not
> program" value. :)

Makes me wonder just a little: my system is perfectly fine with 0x02
written to offset 0x55. (Yes, it is an Athlon compiled kernel.. something
I've been doing ever since I've been using this machine). It had it's
problems when I originally got it

>
> --
> Roberto Jung Drebes <drebes@inf.ufrgs.br>
> Porto Alegre, RS - Brasil
> http://www.inf.ufrgs.br/~drebes/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

