Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290262AbSAOTAR>; Tue, 15 Jan 2002 14:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290259AbSAOTAI>; Tue, 15 Jan 2002 14:00:08 -0500
Received: from amdext.amd.com ([139.95.251.1]:25797 "EHLO amdext.amd.com")
	by vger.kernel.org with ESMTP id <S290255AbSAOS7u>;
	Tue, 15 Jan 2002 13:59:50 -0500
X-Server-Uuid: 02753650-11b0-11d5-bbc5-00508bf987eb
Message-ID: <3C447C15.A9673272@cmdmail.amd.com>
Date: Tue, 15 Jan 2002 10:59:33 -0800
From: "Amit Gupta" <amit.gupta@amd.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Luigi Genoni" <kernel@Expansa.sns.it>, linux-kernel@vger.kernel.org
Subject: Re: arpd not working in 2.4.17 or 2.5.1
In-Reply-To: <Pine.LNX.4.44.0201151555590.24858-100000@Expansa.sns.it>
X-WSS-ID: 105AA39C276528-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


But arp>1024 is Very Important, else linux will never be able to talk to more
than 1024 clients !

Linux is my favourite and I wonder if this limit will kill linux for the race
with Solaris/M$ server market. So pls save me :) and help neighour.c/network
layer in new kernel.

Thanks in Advance.


Luigi Genoni wrote:

> Latest  kernel I saw working with arpd (user space daemon) I am manteining
> is 2.2.16, then from 2.4.4 (for 2.4 series), some changes were done to
> kernel so that the kernel does not talk correctly with the device
> /dev/arpd anymore.
> It is not the first time I write about this on lkml, but it seems none is
> interested in manteining the kernel space component for arpd support.
> I did some investigation, but the code for arpd support itself inside of
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
> > I am running 2.5.1 kernel on a 2 AMD processor system and have enable
> > routing messages, netlink and arpd support inside kernel as described in
> > arpd docs.
> >
> > Then after making 36 character devices, when I run arpd, it's starts up
> > but always keeps silent (strace) and the kernel also does not keep it's
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
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >


