Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbTJGLHQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 07:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbTJGLHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 07:07:16 -0400
Received: from mail01.hansenet.de ([213.191.73.61]:31709 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP id S262186AbTJGLF7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 07:05:59 -0400
Date: Tue, 7 Oct 2003 13:05:51 +0200
From: Malte =?ISO-8859-1?Q?Schr=F6der?= <MalteSch@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 3c59x on 2.6.0-test3->test6 slow
Message-Id: <20031007130551.36899cd9.MalteSch@gmx.de>
In-Reply-To: <200310070631.30972.MalteSch@gmx.de>
References: <200310061529.56959.domen@coderock.org>
	<200310070144.47822.domen@coderock.org>
	<Pine.LNX.4.53.0310062016340.19396@montezuma.fsmlabs.com>
	<200310070631.30972.MalteSch@gmx.de>
X-Mailer: Sylpheed version 0.9.5claws28 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Oct 2003 06:31:30 +0200
Malte Schröder <MalteSch@gmx.de> wrote:

> mii-tool does not work for me either. I thought mine was outdated or something 
> like that ;)
> Oh, kernel is -test6-mm4.
> 
> # mii-tool -V
> mii-tool.c 1.9 2000/04/28 00:56:08 (David Hinds)
> 
> # mii-tool eth0
> SIOCGMIIPHY on 'eth0' failed: Operation not supported

just tested this with a RealTek-NIC (8139too), it gives the same message.

> 
> On Tuesday 07 October 2003 02:18, Zwane Mwaikambo wrote:
> > On Tue, 7 Oct 2003, Domen Puncer wrote:
> > > On Tuesday 07 of October 2003 00:43, Zwane Mwaikambo wrote:
> > > > On Tue, 7 Oct 2003, Domen Puncer wrote:
> > > > > > Ok, could you send your .config too, i use the 3c59x driver and
> > > > > > haven't noticed this in 2.6.0-test5-mm4. My card is;
> > > > >
> > > > > .config at the end of mail
> > > >
> > > > Sorry i forgot to ask for a dmesg too (from a kernel exhibiting the
> > > > problem)
> > >
> > > 0000:00:0a.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xd400. Vers LK1.1.19
> > > eth0: no IPv6 routers present
> > > eth0: Setting full-duplex based on MII #24 link partner capability of
> > > 0141.
> >
> > What is your link peer?
> >
> > > Might be relevant... the last line is lagged a couple of seconds, and
> > > network works fine before i see that line in dmesg.
> >
> > I'm also curious as to why mii-tool doesn't work, can you attach an strace
> > mii-tool eth0?
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> -- 
> ---------------------------------------
> Malte Schröder
> MalteSch@gmx.de
> ICQ# 68121508
> ---------------------------------------
> 
> 
