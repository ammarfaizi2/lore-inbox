Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161204AbWBULZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161204AbWBULZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 06:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161219AbWBULZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 06:25:56 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:6544 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161204AbWBULZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 06:25:55 -0500
Date: Tue, 21 Feb 2006 12:25:25 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Greg KH <greg@kroah.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-pm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] [PATCH 3/5] [pm] Respect the actual device power states in sysfs interface
Message-ID: <20060221112525.GA22068@elf.ucw.cz>
References: <Pine.LNX.4.50.0602171758160.30811-100000@monsoon.he.net> <20060218155543.GE5658@openzaurus.ucw.cz> <Pine.LNX.4.50.0602191557520.8676-100000@monsoon.he.net> <20060220004635.GA22576@kroah.com> <Pine.LNX.4.50.0602200955030.12708-100000@monsoon.he.net> <20060220220404.GA25746@kroah.com> <Pine.LNX.4.50.0602201655580.21145-100000@monsoon.he.net> <20060221105711.GK21557@elf.ucw.cz> <Pine.LNX.4.50.0602210312020.10683-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0602210312020.10683-100000@monsoon.he.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > However, there are a couple of things to note:
> > >
> > > - These patches don't create a new API; they fix the semantics of an
> > >   existing API by restoring them to its originally designed semantics.
> >
> > They may reintroduce "original" semantics, but they'll break
> > applications needing 2.6.15 semantic (where 2 meant D3hot).
> 
> Like what?

Like:

http://article.gmane.org/gmane.linux.kernel/364195/match=pavel+2+sys+power+state+pcmcia
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
