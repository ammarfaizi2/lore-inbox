Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317232AbSGNXbv>; Sun, 14 Jul 2002 19:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317253AbSGNXbu>; Sun, 14 Jul 2002 19:31:50 -0400
Received: from AMontpellier-205-1-4-20.abo.wanadoo.fr ([217.128.205.20]:40663
	"EHLO awak") by vger.kernel.org with ESMTP id <S317232AbSGNXbr> convert rfc822-to-8bit;
	Sun, 14 Jul 2002 19:31:47 -0400
Subject: Re: apm power_off on smp
From: Xavier Bestel <xavier.bestel@free.fr>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pozsar Balazs <pozsy@uhulinux.hu>,
       Kelledin <kelledin+LKML@skarpsey.dyndns.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1026693542.13885.94.camel@irongate.swansea.linux.org.uk>
References: <Pine.GSO.4.30.0207150101150.27346-100000@balu> 
	<1026693542.13885.94.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.7 
Date: 15 Jul 2002 01:34:02 +0200
Message-Id: <1026689642.2077.21.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun 15/07/2002 à 02:39, Alan Cox a écrit :
> On Mon, 2002-07-15 at 00:03, Pozsar Balazs wrote:
> > 
> > Yes, all I want is poweroff.
> > I understand that apm is not smp safe, and pretty much all of it is
> > disabled in smp mode.
> > 
> > What i do not understand is why the poweroff functionality is disabled by
> > default.
> 
> Because it too is unsafe on some machines

Would it be possible to use the CPU-hotplug patch to unplug all CPUs
except the one entering apm power-off ?

