Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132281AbRCaFil>; Sat, 31 Mar 2001 00:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132301AbRCaFic>; Sat, 31 Mar 2001 00:38:32 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:52678 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S132281AbRCaFiY>;
	Sat, 31 Mar 2001 00:38:24 -0500
Message-Id: <200103310537.f2V5bDO06729@pcug.org.au>
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
   Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
   Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Recent problems with APM and XFree86-4.0.1 
In-Reply-To: Your message of Sat, 31 Mar 2001 02:15:14 +0200.
             <20010331021514.A6784@pcep-jamie.cern.ch> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2394.986017034.1@rustcorp.com.au>
Date: Sat, 31 Mar 2001 15:37:14 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jamie,

Jamie Lokier <lk@tantalophile.demon.co.uk> writes:
> 
> On that theme of power management with X problems, I have been having
> trouble with my laptop crashing when the lid is closed, instead of
> suspending as it used to.  The laptop is a Toshiba Satellite 4070CDT.

Can you please try adding
	Option	"NoPM"
to the device section of XF86Config or (XF86Config) and then try suspending
and resuming.

This made suspend/resume much more reliable on the Thinkpad 600E with
XFree86 4.  Also you could try XFree86 4.0.2, as I know that it actually
does interact with APM (4.0.1 may have as well - I am not sure).

Cheers,
Stephen Rothwell		sfr@canb.auug.org.au
