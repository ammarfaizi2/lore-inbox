Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314278AbSGIKYh>; Tue, 9 Jul 2002 06:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314284AbSGIKYg>; Tue, 9 Jul 2002 06:24:36 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:2005 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S314278AbSGIKYf>; Tue, 9 Jul 2002 06:24:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Bernd Schubert <bernd-schubert@web.de>
To: Michael Gruner <stockraser@yahoo.de>, linux-kernel@vger.kernel.org
Subject: Re: freezing afer switching from graphical to console
Date: Tue, 9 Jul 2002 12:27:15 +0200
User-Agent: KMail/1.4.2
References: <1026193021.1076.29.camel@highflyer>
In-Reply-To: <1026193021.1076.29.camel@highflyer>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207091227.15957.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

we have seen it, too. Seems to be graphics card dependend (ati ones are not 
effected, but nvidia cards are ) and what powersaving mode is enabled in the 
BIOS (Suspend for the Monitor causes a lock up when switching from X to the 
console, but when using VSync/empty screen (or something like this) all works 
fine).

Bernd

On Tuesday 09 July 2002 07:38, Michael Gruner wrote:
> Hi,
>
> since 2.4.17 I have got a problem: trying to switch from graphical
> screen to console or to stop my X-session my box freezes. The screen
> gets black and nothing more happens. Pressing any keys or trying to
> switch to another console the box does not do anything. Only o cold
> restart brings the box up again.
>
> Hardware is a MSI6126 with a 440bx chipset. The processor is a 400 MHZ
> Celeron on a MS6905 ppga 370 to slot 1 cpu converter. In former times
> there were 256MB RAM in there but I got a lot of segfaults during
> compiling the kernel. So i removed 128MB and now compiling runs fine.
> So I don't think it might be a hardware failure?!
>
> Problems had be seen very often with kernel 2.4.18, now with 2.4.19-rc1
> not as often as before. That means: it happens maybe 1 or 2 times a
> week. The box is shutted down every day.
>
> Are there any hints for solving this problem?
>
> best regards,
>  Michael

