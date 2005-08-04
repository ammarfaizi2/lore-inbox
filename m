Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262754AbVHDVtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262754AbVHDVtT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 17:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262752AbVHDVrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 17:47:31 -0400
Received: from compunauta.com ([69.36.170.169]:60076 "EHLO compunauta.com")
	by vger.kernel.org with ESMTP id S262726AbVHDVp2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 17:45:28 -0400
From: Gustavo Guillermo =?iso-8859-1?q?P=E9rez?= 
	<gustavo@compunauta.com>
Organization: www.compunauta.com
To: etienne.lorrain@masroudeau.com, linux-kernel@vger.kernel.org
Subject: Re: IDE disk and HPA
Date: Thu, 4 Aug 2005 16:45:23 -0500
User-Agent: KMail/1.8
References: <3235.192.168.201.6.1123157467.squirrel@www.masroudeau.com>
In-Reply-To: <3235.192.168.201.6.1123157467.squirrel@www.masroudeau.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200508041645.23825.gustavo@compunauta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Jueves, 4 de Agosto de 2005 07:11, Etienne Lorrain escribió:
> > > > My question is now: why is an HPA disabled i.e. disprotected when
> > > > detected? Why not let the HPA alone, because a certain set of disk
> > > > sectors shall not be accessible by the OS?
> > >
> > > Because the HPA is most commonly used to hide all but a fraction of a
> > > disk to work with older BIOSes.
> >
> > But as to my knowledge, the HPA was had been introduced to allow HW
> > vendors to store things like diagnostic programs in a part of the
> > disk protected from partitioning and filesystems.
> > The point is, IF there is an HPA, there MIGHT be a partitioning
> > scheme and some filesystems on the disk which rely on the size of
> > disk being the native size MINUS the HPA.
>
>   If those HW vendors want to store software in the HPA of the IDE
>  hard disk, and they employ people able to read the IDE specifications,
>  they know that this HPA can be protected by password and so Linux
>  just display a failure when trying to restore the capacity of the
>  Hard Disk - because it lacks the unlocking password.
If I want to upgrade my IDE Hard drive by my self, how can I restore that kind 
of data on other diferent PC? HPA should not exist, there are a lot of other 
ways to store restore or diagnostics apps, Hibernation and Quick Restores 
should be handled in other way, I have once an omnibook (earth unplugged) and 
I can only reinstall Linux, because the host protected area does not allow me 
to install The Original OS, in other PC with the porper hardware and back it 
to the laptop.
This HPA should be optional, but never by default, I once need to have them 
disabled (where is the specifications from the manufacturer to reproduce them 
in a new hard disk media).
:|
-- 
Gustavo Guillermo Pérez
Compunauta uLinux
www.compunauta.com
