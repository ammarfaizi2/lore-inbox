Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318602AbSHAAQC>; Wed, 31 Jul 2002 20:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318611AbSHAAQC>; Wed, 31 Jul 2002 20:16:02 -0400
Received: from ns.suse.de ([213.95.15.193]:41745 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318602AbSHAAQB>;
	Wed, 31 Jul 2002 20:16:01 -0400
Date: Thu, 1 Aug 2002 02:19:27 +0200
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
       David Luyer <david_luyer@pacific.net.au>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19ac3rc3 on IBM x330/x340 SMP - "ps" time skew
Message-ID: <20020801021927.M10436@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	David Luyer <david_luyer@pacific.net.au>,
	linux-kernel@vger.kernel.org
References: <200207311914.g6VJEG5308283@saturn.cs.uml.edu> <1028162237.13008.26.camel@irongate.swansea.linux.org.uk> <20020801014925.L10436@suse.de> <1028165457.13346.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1028165457.13346.1.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Thu, Aug 01, 2002 at 02:30:57AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 02:30:57AM +0100, Alan Cox wrote:
 > sysconf is implemented in glibc. Right now this is done by poking around
 > in /proc/cpuinfo.

Gotcha, that's what I feared.

 > The kernel doesn't export the data very nicely. With
 > 2.5 and Rusty's hot swappable processors we need to export the data even
 > more explicitly.

driverfs objects perhaps ? Or something more lightweight ?

        Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
