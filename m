Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276057AbRKHMOi>; Thu, 8 Nov 2001 07:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276576AbRKHMOa>; Thu, 8 Nov 2001 07:14:30 -0500
Received: from AMontpellier-201-1-6-99.abo.wanadoo.fr ([80.11.171.99]:50189
	"EHLO awak") by vger.kernel.org with ESMTP id <S276057AbRKHMON> convert rfc822-to-8bit;
	Thu, 8 Nov 2001 07:14:13 -0500
Subject: Re: Laptop harddisk spindown?
From: Xavier Bestel <xavier.bestel@free.fr>
To: Samium Gromoff <_deepfire@mail.ru>
Cc: Dominik Kubla <kubla@sciobyte.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200111080502.fA852im17980@vegae.deep.net>
In-Reply-To: <200111080502.fA852im17980@vegae.deep.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.16.100+cvs.2001.11.05.15.34 (Preview Release)
Date: 08 Nov 2001 13:07:52 +0100
Message-Id: <1005221273.13841.19.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

le jeu 08-11-2001 à 06:02, Samium Gromoff a écrit :
> > > 	i have a disk access _every_ 5 sec, unregarding the system load, 
> > >     24x7x365, so i suppose while it doesnt hurts me, it hurts folks with power
> > >     bound boxes...

That's a kernel daemon called kupdated. Under Linux buffers are flushed
every 5 seconds (I don't like this myself, it should be triggered by
something dependant on free mem, dirty buffers, disk access, etc. but
not time, this doesn't scale.

Under 2.2 you can try the noflushd package - perhaps it works on 2.4, I
haven't tried. It works more or less.

	Xav

