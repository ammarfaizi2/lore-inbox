Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270387AbRHMStz>; Mon, 13 Aug 2001 14:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270401AbRHMStq>; Mon, 13 Aug 2001 14:49:46 -0400
Received: from mail.nep.net ([12.23.44.24]:39184 "HELO nep.net")
	by vger.kernel.org with SMTP id <S270387AbRHMSti>;
	Mon, 13 Aug 2001 14:49:38 -0400
Message-ID: <19AB8F9FA07FB0409732402B4817D75A038A5F@FILESERVER.SRF.srfarms.com>
From: "Ryan C. Bonham" <Ryan@srfarms.com>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Hang problem on Tyan K7 Thunder resolved -- SB Live! heads-up
Date: Mon, 13 Aug 2001 14:53:34 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Ok I am going to stick my two cents in here.. I am not a Linux programmer,
and I am not going to pretend I am, but I do use Linux, have for quite some
time.. I am also implementing Linux in a business.. At home I use custom
built kernels, and play with experimental drivers, etc.. I patch/compile new
kernels all the time. I am running 2.4.8 at my house..(I have a sound
blaster live, and haven't had any problems with that...(all this is besides
the point)..

Anyways,  more to the point.. I don't see the problem with linus putting the
new driver in the 2.4.8 kernel.. Users who are compiling their own kernels,
know that a broken driver is a risk with any kernel.. And for the rest of
the users that rely on Redhat or another Dist company to provide kernels,
are fine, because I know Redhat won't package 2.4.8 with a broken sound
driver like that.. They will either fix (patch) it, or use 2.4.7.. As far as
this being a stable kernel release.. Ok that's true, so why not put it in
the AC tree and work out the bugs with there instead of Linus kernel..

So my basic question is; Alan, can you leave the new sound driver in your AC
kernels? Your kernels are great, and I would love to run them with the new
driver, even if it means I have to find some problems... 

Ok i am done putting my two cents in where it is't wanted :)

Ryan

> -----Original Message-----
> From: Linus Torvalds [mailto:torvalds@transmeta.com]
> Sent: Sunday, August 12, 2001 6:10 PM
> To: Alan Cox
> Cc: Manuel McLure; linux-kernel@vger.kernel.org
> Subject: Re: Hang problem on Tyan K7 Thunder resolved -- SB Live!
> heads-up
> 
> 
> 
> On Sun, 12 Aug 2001, Alan Cox wrote:
> >
> > so I think Linus should do the only sane thing - back it 
> out. I'm backing
> > it out of -ac. Of my three boxes, one spews noise, one 
> locks up smp and
> > one works.
> 
> The problem with backing it out is that apparently nobody has tried to
> really maintain it for a year, and if it gets backed out 
> nobody will even
> bother to try to fix it. So I'll let it be for a while, at least.
> 
> 		Linus
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
