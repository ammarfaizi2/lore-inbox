Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbTEUVid (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 17:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbTEUVid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 17:38:33 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:39176 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S262271AbTEUVib (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 17:38:31 -0400
Date: Wed, 21 May 2003 23:51:16 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Manuel Estrada Sainz <ranty@debian.org>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, jt@hpl.hp.com,
       Pavel Roskin <proski@gnu.org>, Oliver Neukum <oliver@neukum.org>,
       David Gibson <david@gibson.dropbear.id.au>, zippel@linux-m68k.org
Subject: Re: [PATCH] Re: request_firmware() hotplug interface, third round and a halve
Message-ID: <20030521215116.GA3441@mars.ravnborg.org>
Mail-Followup-To: Manuel Estrada Sainz <ranty@debian.org>,
	Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
	Simon Kelley <simon@thekelleys.org.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, jt@hpl.hp.com,
	Pavel Roskin <proski@gnu.org>, Oliver Neukum <oliver@neukum.org>,
	David Gibson <david@gibson.dropbear.id.au>, zippel@linux-m68k.org
References: <20030517221921.GA28077@ranty.ddts.net> <20030521072318.GA12973@kroah.com> <20030521185212.GC12677@ranty.ddts.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030521185212.GC12677@ranty.ddts.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 21, 2003 at 08:52:12PM +0200, Manuel Estrada Sainz wrote:
>  
>  Maybe kbuild could allow forcing one option from another, a companion
>  for 'depends', lets call it 'hard_depends'
> 
> 	 depends FOO
> 		If FOO is not there the entry won't even be shown in the
> 		menu.
> 	 hard_depends FOO 
> 		FOO gets set to satisfy the dependency.
> 

Roman Zippel introduced: "enable" in his latest Kconfig goodies:
http://marc.theaimsgroup.com/?l=linux-kernel&m=105274692328723&w=2

Would that be usefull for you?
This would allow you to set CONFIG_LOADER for the drivers that
really needs it.

IIRC this is not included in Linus-BK yet.

	Sam
