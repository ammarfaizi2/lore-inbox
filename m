Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317251AbSGNXpG>; Sun, 14 Jul 2002 19:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317253AbSGNXpF>; Sun, 14 Jul 2002 19:45:05 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:39414 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317251AbSGNXpE>; Sun, 14 Jul 2002 19:45:04 -0400
Subject: Re: apm power_off on smp
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Pozsar Balazs <pozsy@uhulinux.hu>,
       Kelledin <kelledin+LKML@skarpsey.dyndns.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1026689642.2077.21.camel@bip>
References: <Pine.GSO.4.30.0207150101150.27346-100000@balu> 
	<1026693542.13885.94.camel@irongate.swansea.linux.org.uk> 
	<1026689642.2077.21.camel@bip>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 15 Jul 2002 01:57:24 +0100
Message-Id: <1026694644.13885.99.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-15 at 00:34, Xavier Bestel wrote:
> > > What i do not understand is why the poweroff functionality is disabled by
> > > default.
> > 
> > Because it too is unsafe on some machines
> 
> Would it be possible to use the CPU-hotplug patch to unplug all CPUs
> except the one entering apm power-off ?

Only if your hardware supports true CPU unplugging and your BIOS
supports APM for it. That is wildly improbable at best

