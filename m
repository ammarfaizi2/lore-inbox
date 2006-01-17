Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbWAQIiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWAQIiq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 03:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWAQIiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 03:38:46 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:64546 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932337AbWAQIip convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 03:38:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dn8+5Fqkt1M6aO/6Dx04WoIFS0DCv5yb56nzU7faB0gN8IW/24kHO7RWLIj0C963wxPvozw1igeUbBhU3ATPLpZniO4h5dfdrE+Y+fuvZUcM8EcPO3W5hVXCQVX5aj06GuUDSMkQR98bl9tbjfFZ0Tj3Zv1yNt8xGl8wEnzs6s4=
Message-ID: <6e6e20a10601170038l2a1641edjdc8466093eec423a@mail.gmail.com>
Date: Tue, 17 Jan 2006 09:38:43 +0100
From: =?ISO-8859-1?Q?Bj=F6rn_Nilsson?= <bni.swe@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 3COM 3C940, does not work anymore after upgrade to 2.6.15
Cc: shemminger@osdl.org
In-Reply-To: <20060116100156.0a273b54@dxpl.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <6e6e20a10601160751v362d2312v6c99fa8db64ce7e1@mail.gmail.com>
	 <20060116100156.0a273b54@dxpl.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/06, Stephen Hemminger <shemminger@osdl.org> wrote:
> On Mon, 16 Jan 2006 16:51:22 +0100
> Björn Nilsson <bni.swe@gmail.com> wrote:
>
> > Hi,
> >
> > I have a problem with the network card attached to my motherboard
> > after doing an upgrade of the kernel from 2.6.11 to 2.6.15.
> >
> > The Motherboard is an ASUS P4P800, and the network card is 3COM 3C940
> > and is afaik a variant of SysKonnect SK-98xx.
> >
> > It worked with 2.6.15 until I shut the system down and started it up
> > again for the first time with 2.6.15 running, and now the card does
> > not work anymore. The driver is loaded, and it detects that the cable
> > is plugged in and the interface is brought up (so says dmesg). The
> > green led on the card is now turned off, it used to be on before.
> >
> > I have tried to reinstall the system from scratch (Using Debian 3.1
> > installer cd), and to my astonishment the card is not working like it
> > used to.
> >
> > It seems like 2.6.15 set the card in some state so it does not work
> > anymore. Is this even possible? I have tried power cycling, even
> > disconnected the power coord from the computer.
> >
> > When i used 2.6.11 I was using the sk98lin driver, when upgrading it
> > is possible the newer skge driver was used, however I am not sure.
> >
> > Debian installer 3.1 uses 2.6.8 kernel with sk98lin driver.
> >
> > I have found others with the same/similar problem:
> > http://bugs.gentoo.org/show_bug.cgi?id=100258
> > http://marc.theaimsgroup.com/?l=linux-netdev&m=112268414417743&w=2
> >
> > But for me the card does not work even with 2.6.15. I dont have
> > Wind*ws to test with, so I cant test the solution in one of the above
> > emails.
> >
> > If the driver in 2.6.15 breaks cards of this type it is qiute a
> > serious bug I think. Anyone have any suggestions as to how I can try
> > to fix this? Reset the card in some way maybe?
> >
> > Please CC me.
> >
> > Regards
> > /Björn
>
> Pleas send me some more info.
> * console output (dmesg)
> * lspci -v
> * which modules are loaded (lsmod)
>
>
> --
> Stephen Hemminger <shemminger@osdl.org>
> OSDL http://developer.osdl.org/~shemminger
>

I am currently travelling and dont have access to the machine right
now, but I will post this info later in the week or this weekend.
