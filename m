Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276094AbRJKLmN>; Thu, 11 Oct 2001 07:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276097AbRJKLmE>; Thu, 11 Oct 2001 07:42:04 -0400
Received: from kullstam.ne.mediaone.net ([66.30.138.48]:32386 "HELO
	kullstam.ne.mediaone.net") by vger.kernel.org with SMTP
	id <S276069AbRJKLlr>; Thu, 11 Oct 2001 07:41:47 -0400
From: "Johan Kullstam" <kullstam@ne.mediaone.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Tulip problem in Kernel 2.4.11
In-Reply-To: <000701c151c4$0e6933e0$0300a8c0@theburbs.com>
	<87u1x6zmdy.fsf@penny.ik5pvx.ampr.org>
Organization: none
Date: 11 Oct 2001 07:38:46 -0400
In-Reply-To: <87u1x6zmdy.fsf@penny.ik5pvx.ampr.org>
Message-ID: <m2adyy5ruh.fsf@euler.axel.nom>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierfrancesco Caci <ik5pvx@penny.ik5pvx.ampr.org> writes:

> :-> "Jamie" == Jamie  <darkshad@home.com> writes:
> 
>     > Hello there is a definate problem with the tulip drivers in the 2.4.11
>     > kernel.
>     > I have a DEC DC 21041 NIC which uses the tulip drivers.  I use the 2.2.19
>     > kernel and there are
>     > two different sets of tulip drivers listed in that kernel which
>     > I can choose 
>     > from in the 2.4.11 kernel there is only one. When I do a
>     > modprobe tulip the 
>     > driver loads fine as you can see bellow there are no strange
>     > error messages 
>     > ect.  But I can not communicate though this one NIC. When I use
>     > the 2.2.19 
>     > Kernel it works fine.
> 
> I can add to this that 2.4.2 works fine, I've tried 2.4.9 and 2.4.11
> and I can't use the lan either. 
> In 2.4.11, I can see that the driver can sense if I plug/unplug the
> connector (10BaseT, connected to a Compaq Netelligent 8 port hub), but
> nothing more.

linux 2.4.11 is broken with respect to tulip driver and dec 21041
chipset.  my 21041 card doesn't work either.  what you can do is the
following.  compile kernel using a module for tulip driver.  go to
tulip.sourceforge.net.  get tulip-0.9.14.  unpack it.  for each new
kernel, manually (or make a script) compile a tulip driver in
tulip-0.9.14 and install it in
/lib/module/2.4.X/kernel/drivers/net/tulip.  this will replace the
broken driver and keep you going.

-- 
J o h a n  K u l l s t a m
[kullstam@mediaone.net]
