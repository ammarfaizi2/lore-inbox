Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbUKOOt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbUKOOt3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 09:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbUKOOt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 09:49:28 -0500
Received: from canuck.infradead.org ([205.233.218.70]:19725 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261614AbUKOOr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 09:47:59 -0500
Subject: Re: GPL Violation of 'sveasoft' with GPL Linux Kernel/Busybox +code
From: David Woodhouse <dwmw2@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Bill Davidsen <davidsen@tmr.com>,
       =?ISO-8859-1?Q?=3D=3Futf-8=3Fq=3FRapha=EBl?= Rigo LKML?= 
	<lkml@twilight-hall.net>,
       Michael Poole <mdpoole@troilus.org>, davids@webmaster.com,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1100124861.20794.10.camel@localhost.localdomain>
References: <87actqfigw.fsf@sanosuke.troilus.org>
	 <87actqfigw.fsf@sanosuke.troilus.org>
	 <200411092328.16426.dtor_core@ameritech.net> <419283EF.8050708@tmr.com>
	 <87686367-336D-11D9-857E-000393ACC76E@mac.com>
	 <1100124861.20794.10.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1100530044.8191.6920.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Mon, 15 Nov 2004 14:47:24 +0000
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-10 at 22:14 +0000, Alan Cox wrote:
> On Mer, 2004-11-10 at 23:09, Kyle Moffett wrote:
> > GPL.  I believe that a single binary firmware image is a single "work"
> > according to the definition provided in the GPL, and therefore by
> > distributing their code as a part of it, they have implicitly applied 
> 
> The firmware image is a file system so I'd suspect its "mere
> aggregation" just like say a CD of GPL and BSD software, or your root
> file system...

That's possibly true of any userspace applications they've added.

However, if you were arguing that the presence of the GPL'd kernel and
the non-GPL'd modules was OK because it's "mere aggregation", that would
be a different and far less supportable position -- since the beast
cannot even come close to serving its purpose or being at all useful if
you take away either the kernel, or the modules in question. 
Distributing a work which depends on both the kernel and those network
driver modules is a clear violation of the GPL. But that's something
that Cisco themselves are doing.

-- 
dwmw2

