Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310213AbSCAHZk>; Fri, 1 Mar 2002 02:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310382AbSCAHVr>; Fri, 1 Mar 2002 02:21:47 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:10252 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S310369AbSCAHUA>; Fri, 1 Mar 2002 02:20:00 -0500
Date: Fri, 1 Mar 2002 08:19:47 +0100
From: Jurriaan on Alpha <thunder7@xs4all.nl>
To: Dave Jones <davej@suse.de>, James Simmons <jsimmons@transvirtual.com>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] tdfx ported to new fbdev api
Message-ID: <20020301071947.GA13938@alpha.of.nowhere>
Reply-To: thunder7@xs4all.nl
In-Reply-To: <20020228214045.E32662@suse.de> <Pine.LNX.4.10.10202281259230.20040-100000@www.transvirtual.com> <20020228220847.J32662@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020228220847.J32662@suse.de>
User-Agent: Mutt/1.3.27i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jones <davej@suse.de>
Date: Thu, Feb 28, 2002 at 10:08:47PM +0100
> On Thu, Feb 28, 2002 at 01:00:04PM -0800, James Simmons wrote:
>  > > > The patch is against 2.5.5-dj2
>  > > > http://www.transvirtual.com/~jsimmons/tdfx.diff
>  > >  Is this one different to the one I saw last time?
>  > Actually no. I think the driver hasn't changed. I does work for me. Did
>  > you try it out again.
> 
>  Ok. I didn't look too deeply last time, but it died immediately
>  on switching the display, and was really dead, no keyboard leds,
>  nada.
> 
That was my experience also (Voodoo 4500 pci/Alpha architecture).
However, the VIDCFG_2X handling in his patch worked, and the kernel
(pre-2.4.18) didn't. Luckily, a small patch was accepted to change that.

I'm willing to test any patches for tdfxfb on Alpha.

Good luck,
Jurriaan
-- 
One guide for speakers of Klingon advises them to begin by
purchasing a large supply of napkins.
	Robert O'Reilly [Gowron] on speaking Klingon.
GNU/Linux 2.4.19pre1 on Debian/Alpha 988 bogomips load:1.64 1.33 0.76
