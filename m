Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbTEVGNY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 02:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbTEVGNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 02:13:24 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:22205 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S262226AbTEVGNW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 02:13:22 -0400
Date: Thu, 22 May 2003 08:26:03 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, jt@hpl.hp.com,
       Pavel Roskin <proski@gnu.org>, Oliver Neukum <oliver@neukum.org>,
       David Gibson <david@gibson.dropbear.id.au>, zippel@linux-m68k.org
Subject: Re: [PATCH] Re: request_firmware() hotplug interface, third round and a halve
Message-ID: <20030522062603.GA13224@ranty.ddts.net>
Reply-To: ranty@debian.org
References: <20030517221921.GA28077@ranty.ddts.net> <20030521072318.GA12973@kroah.com> <20030521185212.GC12677@ranty.ddts.net> <20030521215116.GA3441@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030521215116.GA3441@mars.ravnborg.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 21, 2003 at 11:51:16PM +0200, Sam Ravnborg wrote:
> On Wed, May 21, 2003 at 08:52:12PM +0200, Manuel Estrada Sainz wrote:
> >  
> >  Maybe kbuild could allow forcing one option from another, a companion
> >  for 'depends', lets call it 'hard_depends'
> > 
> > 	 depends FOO
> > 		If FOO is not there the entry won't even be shown in the
> > 		menu.
> > 	 hard_depends FOO 
> > 		FOO gets set to satisfy the dependency.
> > 
> 
> Roman Zippel introduced: "enable" in his latest Kconfig goodies:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=105274692328723&w=2
> 
> Would that be usefull for you?
> This would allow you to set CONFIG_LOADER for the drivers that
> really needs it.

 Yep, that is perfect.
 
> IIRC this is not included in Linus-BK yet.

 Nop :( once it is in, I'll start using it. Oh, and I volunteer to
 cleanup the CRC32 stuff on top of that :)

 Have a nice day

 	Manuel

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
