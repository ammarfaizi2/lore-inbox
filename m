Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317283AbSGOACx>; Sun, 14 Jul 2002 20:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317286AbSGOACw>; Sun, 14 Jul 2002 20:02:52 -0400
Received: from AMontpellier-205-1-4-20.abo.wanadoo.fr ([217.128.205.20]:6616
	"EHLO awak") by vger.kernel.org with ESMTP id <S317283AbSGOACw> convert rfc822-to-8bit;
	Sun, 14 Jul 2002 20:02:52 -0400
Subject: Re: apm power_off on smp
From: Xavier Bestel <xavier.bestel@free.fr>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pozsar Balazs <pozsy@uhulinux.hu>,
       Kelledin <kelledin+LKML@skarpsey.dyndns.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1026694644.13885.99.camel@irongate.swansea.linux.org.uk>
References: <Pine.GSO.4.30.0207150101150.27346-100000@balu> 
	<1026693542.13885.94.camel@irongate.swansea.linux.org.uk> 
	<1026689642.2077.21.camel@bip> 
	<1026694644.13885.99.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.7 
Date: 15 Jul 2002 02:05:24 +0200
Message-Id: <1026691525.2077.38.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun 15/07/2002 à 02:57, Alan Cox a écrit :
> > Would it be possible to use the CPU-hotplug patch to unplug all CPUs
> > except the one entering apm power-off ?
> 
> Only if your hardware supports true CPU unplugging and your BIOS
> supports APM for it. That is wildly improbable at best

Err .. my mobo's BIOS is SMP specific and implements APM, so I guess
there is a case where it's useful. It must be something like when
running Win95, which is UP only. Isn't Linux able to return to a UP-like
state (à la Win95) just before entering poweroff ?

Or perhaps my first assumption is false: the APM implementation in my
BIOS just wastes some flash and never intended to be utilized.

