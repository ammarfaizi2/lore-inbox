Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292371AbSBBT77>; Sat, 2 Feb 2002 14:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292369AbSBBT7u>; Sat, 2 Feb 2002 14:59:50 -0500
Received: from [208.29.163.248] ([208.29.163.248]:1491 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S292370AbSBBT7g>; Sat, 2 Feb 2002 14:59:36 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: blumpkin@attbi.com, adam-dated-1013023458.e87e05@flounder.net,
        linux-kernel@vger.kernel.org
Date: Sat, 2 Feb 2002 11:58:42 -0800 (PST)
Subject: Re: should I trust 'free' or 'top'?
In-Reply-To: <E16X3hX-0008Rj-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0202021150370.21319-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

as an outside observer during that time it looked like Linus was rejecting
patches from Rik (at least in part) becouse the reasoning behind them
wasn't fully explained and it appeared to be deteriorating into 'tweak
these magic numbers to fix problem A, discover that that caused problem B,
tweak them again to fix B anc cause C .... tweak them again to fix J and
cause A' type circles with nobody (other then possibly rik) understanding
what was really causing the problems (at least if they did understand them
they weren't posted here)

the fundamental problem was that while the VM would work well most of the
time, once in a while it would hit a pathalogical condition that would
lockup the machine completely, the new VM was seen as not nessasarily
being quite as good in the best cases, but avoiding the worst lockups (of
course it had a few problems of it's own, but these seemed to be easier to
fix without causing additional problems)

David Lang


On Sat, 2 Feb 2002, Alan Cox wrote:

> Date: Sat, 2 Feb 2002 17:11:43 +0000 (GMT)
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> To: blumpkin@attbi.com
> Cc: alan@lxorguk.ukuu.org.uk, adam-dated-1013023458.e87e05@flounder.net,
>      linux-kernel@vger.kernel.org
> Subject: Re: should I trust 'free' or 'top'?
>
> > >The base VM in Linus tree has been broken since before 2.4.0 and while
> > >somewhat better is still that - broken. The major vendors don't ship it for
> > >a reason.
> >
> > Why is this?
>
> Linus kept ignoring Rik's patches and making other changes, then at 2.4.10
> switched to Andrea's VM and ignored most of the follow up changes that
> made that one work
>
> > Believe it or not, im not trying to start a flame war, just trying to
> > understand the logic.
>
> You've got me there. I don't understand either.
>
> Alan
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
