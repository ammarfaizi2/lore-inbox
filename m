Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311402AbSCMWM1>; Wed, 13 Mar 2002 17:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311398AbSCMWMP>; Wed, 13 Mar 2002 17:12:15 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62727 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311399AbSCMWL7>; Wed, 13 Mar 2002 17:11:59 -0500
Subject: Re: your mail
To: root@chaos.analogic.com
Date: Wed, 13 Mar 2002 22:27:35 +0000 (GMT)
Cc: rlievin@free.fr (=?ISO-8859-1?Q?Romain_Li=E9vin?=),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Kernel List)
In-Reply-To: <Pine.LNX.3.95.1020313153432.30430A-100000@chaos.analogic.com> from "Richard B. Johnson" at Mar 13, 2002 03:49:45 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lHDb-0007cX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +                       START(max);=20
> > +                       do {
> > +                               WAIT(max);
> > +                       } while (inbyte(minor) & 0x10);
> 
>              This may never happen. You end up waiting forever!

No - its hidden in his macros. Look harder


