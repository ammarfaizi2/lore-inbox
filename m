Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbVCaNkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbVCaNkM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 08:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVCaNkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 08:40:12 -0500
Received: from host-216-252-217-242.interpacket.net ([216.252.217.242]:16075
	"EHLO forof.hylink.am") by vger.kernel.org with ESMTP
	id S261447AbVCaNkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 08:40:04 -0500
Message-ID: <001001c535f7$1e934790$1000000a@araavanesyan>
From: "Ara Avanesyan" <araav@hylink.am>
To: "Eugene Surovegin" <ebs@ebshome.net>
Cc: <linux-kernel@vger.kernel.org>, <avila@lists.unixstudios.net>
References: <006b01c5047e$1efc78a0$1000000a@araavanesyan> <20050127144441.GB4848@home.fluff.org> <00ae01c533a6$85ddf1f0$1000000a@araavanesyan> <20050330072110.GA7027@gate.ebshome.net>
Subject: Re: Strange memory problem with Linux booted from U-Boot
Date: Thu, 31 Mar 2005 18:39:51 +0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.0
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Mar 28, 2005 at 07:57:52PM +0500, Ara Avanesyan wrote:
> > Hi,
> >
> > I need some help on solving this strange problem.
> > Here is what I have,
> > I have a loadable module (linux.2.4.20) which contains a 2 mb static
gloabal
> > array.
> > When I load it from linux booted via U-Boot the system crashes.
> > Everything works ok if I do the same thing with the same linux booted
with
> > RedBoot.
>
> As usual for such problems, check how different firmware configure
> memory controller, etc. Get dump of relevant chip registers under
> U-Boot and RedBoot and compare them.
>
> Other possible problem area can be firmware -> kernel interface. I'm
> not familiar with that particular chip and RedBoot, but it's not
> uncommon for different firmware to have different conventions for the
> environment in which kernel starts execution.
>
> I'd recommend posting to the specific mail-lists, lkml doesn't seem
> a good place for embedded and firmware related questions :)
>
> --
> Eugene
>

Eugene,

Thanks for your response and ideas.
Actually the problem is concerning to linux part as the same code works fine
within U-Boot as I posted before. This is why I asked lkml for help what
might
cause this behaviour.

__
Thanks,
Ara

