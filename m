Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264298AbUGaVe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264298AbUGaVe6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 17:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbUGaVe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 17:34:58 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:31659 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S264298AbUGaVe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 17:34:56 -0400
Subject: Re: [PATCH] Configure IDE probe delays
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Todd Poynor <tpoynor@mvista.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tim.bird@am.sony.com, dsingleton@mvista.com
In-Reply-To: <1091302522.6910.4.camel@localhost.localdomain>
References: <20040730191100.GA22201@slurryseal.ddns.mvista.com>
	 <1091226922.5083.13.camel@localhost.localdomain>
	 <1091232770.1677.24.camel@mindpipe>
	 <200407311434.59604.vda@port.imtp.ilyichevsk.odessa.ua>
	 <1091297179.1677.290.camel@mindpipe>
	 <1091302522.6910.4.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1091309723.1677.391.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 31 Jul 2004 17:35:23 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-31 at 15:35, Alan Cox wrote:
> On Sad, 2004-07-31 at 19:06, Lee Revell wrote:
> > Maybe we need a CONFIG_ANCIENT_HARDWARE that people can set if they want
> > to use old stuff, and anywhere in the code we take a big hit to make
> > some ancient device work wouldn't get compiled.  Devices could be added
> > to this class as they are identified.
> 
> Wrong way around. You want a CONFIG_BOY_RACER option for people with
> overclocked computers and delay loops "optimised" away.
> 

LOL.  But, the last overclocking I did was when i figured out that
removing the 'SPEED' jumper on my 486/33 would make it run at 50Mhz.  I
am actually working on an embedded system (well, small anyway).  I have
never used Gentoo.

Even if it's not appropriate for this case, there have to be some places
in the kernel where this would be useful.  What about hardware that is 
broken, requiring a device-specific kludge?  Hardware that the kernel
developers would prefer didn't exist.  There have to be some of these. 
Or are most of these already broken out and disabled by default like the
old CMD640 ide bug?

Lee



