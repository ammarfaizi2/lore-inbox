Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266010AbUAQLSa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 06:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266027AbUAQLSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 06:18:30 -0500
Received: from h196n1fls22o974.bredband.comhem.se ([213.64.79.196]:39087 "EHLO
	latitude.mynet.no-ip.org") by vger.kernel.org with ESMTP
	id S266010AbUAQLS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 06:18:29 -0500
X-Mailer: exmh version 2.6.3 04/02/2003 with nmh-1.0.4
To: Adrian Bunk <bunk@fs.tum.de>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>, robert@schwebel.de,
       cliff white <cliffw@osdl.org>, piggin@cyberone.com.au, mpm@selenic.com,
       linux-kernel@vger.kernel.org
Subject: Re: [1/4] better i386 CPU selection 
In-Reply-To: Message from Adrian Bunk <bunk@fs.tum.de> 
   of "Sat, 17 Jan 2004 03:15:32 +0100." <20040117021532.GH12027@fs.tum.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 17 Jan 2004 11:01:22 +0100
From: aeriksson@fastmail.fm
Message-Id: <20040117100122.4C7B53F60@latitude.mynet.no-ip.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > NO! NO!  This prevents development of an AMD embeded system on an
> > "ordinary" machine like this one (Pentium IV). The fact that the
> > timer runs at a different speed means nothing, one just sets the
> > workstation time every day. Please do NOT do this. It prevents
> > important usage.
> 
> What problems exacly are you referring to?
> 
> Besides the AMD Elan cpufreq driver I see nothing where CONFIG_MELAN
> gave you any real difference (except your highest goal is to avoid a
> recompilation when switching from the Pentium 4 to the AMD Elan - but I
> doubt the really "prevents development").
> 
> But I'm not religious about this issue. Let Robert decide, the Elan 
> support is his child.
> 

I guess some code to dynamically check for AMD ELAN would make the time drift problem go away, right? I did notice a description of how to detect an elan in one of the elan manuals. That stuff does not seem to have made its way into the kernel, has it? Should it?

/A

