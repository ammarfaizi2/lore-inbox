Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267498AbTBDVzs>; Tue, 4 Feb 2003 16:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267499AbTBDVzs>; Tue, 4 Feb 2003 16:55:48 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:18839
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267498AbTBDVzr>; Tue, 4 Feb 2003 16:55:47 -0500
Subject: Re: CPU detection
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Banai Zoltan <bazooka@vekoll.vein.hu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030204182603.GC3832@bazooka.saturnus.vein.hu>
References: <20030204182603.GC3832@bazooka.saturnus.vein.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044399675.29825.21.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 04 Feb 2003 23:01:16 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-04 at 18:26, Banai Zoltan wrote:
> Hi!
> 
> I have a Toshiba Satelite S2210CDT.
> There is a problem with detecting CPU frequency.
> It runs on 258Mhz, but it is an 500Mhz Celeron kernels 2.4.19-pre7-ac4
> and 2.4.20.
> i attach the configs and the output of lscpi, /proc/cpu

I trust our measuring code. Most likely the laptop has speedstep so is 
running at 250Mhz to save power. If you've got a currentish -ac kernel
you can load the speedstep cpufreq support and flip the CPU between fast
and slow mode as you want. In some cases APM will also do the work for
you


