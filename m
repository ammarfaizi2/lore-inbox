Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272551AbTHEQZr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 12:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272796AbTHEQZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 12:25:46 -0400
Received: from law11-oe34.law11.hotmail.com ([64.4.16.91]:33553 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S272551AbTHEQYo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 12:24:44 -0400
X-Originating-IP: [165.98.111.210]
X-Originating-Email: [bmeneses_beltran@hotmail.com]
From: "Viaris" <bmeneses_beltran@hotmail.com>
To: <root@chaos.analogic.com>
Cc: <linux-kernel@vger.kernel.org>
References: <Law11-OE35phwFutJLt00010b17@hotmail.com> <Pine.LNX.4.53.0308051121410.248@chaos>
Subject: Re: kernel 2.6.0-test2 hang in Starting RedHat Network Daemon
Date: Tue, 5 Aug 2003 10:24:41 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <Law11-OE34l1GM3h3vL00014305@hotmail.com>
X-OriginalArrivalTime: 05 Aug 2003 16:24:43.0712 (UTC) FILETIME=[14083C00:01C35B6E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In my .config I have enabled CONFIG_UNIX98_PTSY=y, however the persist.

Regards

----- Original Message -----
From: "Richard B. Johnson" <root@chaos.analogic.com>
To: "Viaris" <bmeneses_beltran@hotmail.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Tuesday, August 05, 2003 9:24 AM
Subject: Re: kernel 2.6.0-test2 hang in Starting RedHat Network Daemon


> On Tue, 5 Aug 2003, Viaris wrote:
>
> > Hi all
> >
> > I have problems with this new kernel, I compiled the 2.6.0-test2 but
when
> > start the services this kernel hang in the service starting RedHat
Network,
> > the message are:
> >
> > INIT:Id"1" respawning too fast: disabled for 5 minutes
> > INIT:Id"2" respawning too fast: disabled for 5 minutes
> > INIT:Id"3" respawning too fast: disabled for 5 minutes
> > INIT:Id"4" respawning too fast: disabled for 5 minutes
> > INIT:Id"5" respawning too fast: disabled for 5 minutes
> > INIT:Id"6" respawning too fast: disabled for 5 minutes
> > INIT:Id"4" respawning too fast: disabled for 5 minutes
> > INIT: no more processes left in this runlevel.
> >
> > I have in my grub.conf the oher kernel version 2.4.20, If I start with
this
> > kernel, all work fine.
> >
> > How can I to resolv this problem with new kernel?
> >
> > Thanks in Advanced,
> >
> > Regards
>
> Looks like your `gettys` were unable to open their virtual
> terminals. So, you need to make sure that they are enabled
> in your configuration. (UNIX98_PTYS=y), etc.
>
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
>             Note 96.31% of all statistics are fiction.
>
>
