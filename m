Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316616AbSEPJXX>; Thu, 16 May 2002 05:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316617AbSEPJXX>; Thu, 16 May 2002 05:23:23 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:7438 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S316616AbSEPJXS>; Thu, 16 May 2002 05:23:18 -0400
Message-Id: <200205160919.g4G9J0Y16751@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Xavier Bestel <xavier.bestel@free.fr>
Subject: Re: No Network after Compiling,2.4.19-pre8 under Debian Woody(Long Message)
Date: Thu, 16 May 2002 12:21:25 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <003c01c1fb9d$345e0a20$2000a8c0@metalbox> <200205160618.g4G6I5Y16037@Port.imtp.ilyichevsk.odessa.ua> <1021539953.17761.150.camel@bip>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 May 2002 07:05, Xavier Bestel wrote:
> Le jeu 16/05/2002 ? 13:20, Denis Vlasenko a ?crit :
> > On 15 May 2002 14:38, Xavier Bestel wrote:
> > > Yes, it works at 10Mbit. But the driver doesn't do speed negociation,
> > > it doesn't even see the MII registers. However I think RTL8139 cards
> > > have MII registers. I quickly looked at the source but didn't see
> > > anything special.
> >
> > Becker's diag utils say there is *no* MII in RTL8139, just something
> > vaguely resembling that. I have trouble persuading 8139 to work in
> > 100mbit fdx, it insists on half duplex. :-(
>
> How do you do this ? Mine only accepts 10Mbits ...
> I tried with mii-diad and with rtl8139-diag.

Tried too, rtl8139-diag set my nic to 10mbit and I could not boot
with NFS root anymore. 8-]. Brought DOS-based conf utility and
used it.

> rtl8139-diag shows "internal MII-compatible registers", then "Link
> Partner Ability register 0x40a1" (seems what I want), but then "I'm
> advertising 0000" and "Link partner capability is 0000".
> I'm lost.

Donald Becker's utils, while definitely useful, aren't very pretty.
For example, one needs to read source to learn switches.
Are they maintained?
--
vda
