Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289598AbSAOTf3>; Tue, 15 Jan 2002 14:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290265AbSAOTfU>; Tue, 15 Jan 2002 14:35:20 -0500
Received: from [198.17.35.35] ([198.17.35.35]:50345 "HELO mx1.peregrine.com")
	by vger.kernel.org with SMTP id <S289598AbSAOTfH>;
	Tue, 15 Jan 2002 14:35:07 -0500
Message-ID: <B51F07F0080AD511AC4A0002A52CAB445B2AA0@ottonexc1.ottawa.loran.com>
From: Dana Lacoste <dana.lacoste@peregrine.com>
To: "'Luigi Genoni'" <kernel@Expansa.sns.it>, Amit Gupta <amit.gupta@amd.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: arpd not working in 2.4.17 or 2.5.1
Date: Tue, 15 Jan 2002 11:34:51 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a 2.4 compatible arpd running, but with our
company being bought by a big US software company
I'm having trouble convincing management to allow
the GPL release.  It's becoming very important so
I'm hopeful that I'll be successful shortly, but
until then I have to be quiet :)

--
Dana Lacoste      - Linux Developer
Peregrine Systems - Ottawa, Canada

(Note that Peregrine acquired Loran, and jlayes@loran.com
is an email address of a former employee, so i'm kind of
the relevant person to talk to for arpd stuff, because that
other address won't work :)

> -----Original Message-----
> From: Luigi Genoni [mailto:kernel@Expansa.sns.it]
> Sent: January 15, 2002 10:03
> To: Amit Gupta
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: arpd not working in 2.4.17 or 2.5.1
> 
> 
> Latest  kernel I saw working with arpd (user space daemon) I 
> am manteining
> is 2.2.16, then from 2.4.4 (for 2.4 series), some changes were done to
> kernel so that the kernel does not talk correctly with the device
> /dev/arpd anymore.
> It is not the first time I write about this on lkml, but it 
> seems none is
> interested in manteining the kernel space component for arpd support.
> I did some investigation, but the code for arpd support 
> itself inside of
> the kernel seems to be ok, something else is wrong with neighour.c.
> 
> So at less I can say the user space daemon works well on 2.2.16 I have
> around ;).
> 
> Luigi
> 
> On Mon, 14 Jan 2002, Amit Gupta wrote:
> 
> >
> > Hi All,
> >
> > I am running 2.5.1 kernel on a 2 AMD processor system and 
> have enable
> > routing messages, netlink and arpd support inside kernel as 
> described in
> > arpd docs.
> >
> > Then after making 36 character devices, when I run arpd, 
> it's starts up
> > but always keeps silent (strace) and the kernel also does 
> not keep it's
> > 256 arp address limit.
> >
> > Pls help fix it, I need linux to be able to talk to more than 1024
> > clients.
> >
> > Thanks in Advance.
> >
> > Amit
> > amit.gupta@amd.com
> >
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
