Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311917AbSDIW0h>; Tue, 9 Apr 2002 18:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311948AbSDIW0g>; Tue, 9 Apr 2002 18:26:36 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:17294 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S311917AbSDIW0f>;
	Tue, 9 Apr 2002 18:26:35 -0400
Date: Wed, 10 Apr 2002 00:26:05 +0200
From: David Weinehall <tao@acc.umu.se>
To: Daniel Gryniewicz <dang@fprintf.net>
Cc: Andrew Burgess <aab@cichlid.com>, linux-kernel@vger.kernel.org
Subject: Re: Tyan S2462 reboot problems
Message-ID: <20020410002604.F13463@khan.acc.umu.se>
In-Reply-To: <200204091917.g39JHpe15914@athlon.cichlid.com> <20020409161412.777aec9a.dang@fprintf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2002 at 04:14:12PM -0400, Daniel Gryniewicz wrote:
> Hi.
> 
> No, I doubt this has anything to do with Linux.   I have a S2460
> (which his corrected post says he has), which does not power down
> under linux, and *never* warm boots cleanly.  It does power down under
> windows, so I assume ACPI powerdown works and APM does not.  I have
> gone under the assumption that a BIOS upgrade will fix this, but that
> involves putting a floppy into the box, so I haven't done it yet.  The
> warm boot problems consist of either a hang after POST (but before
> bootloader, OS irrelevent), or really bad video corruption.  I don't
> know if it boot with the video corruption, I've never let it try.

Uhm, no, you don't need a floppy in your computer to upgrade the BIOS;
I upgraded it for this TYAN 2466 today, using /dev/bios
<http://www.freiburg.linux.de/OpenBIOS/status/devbios.html>
and it worked perfectly fine.

That said, using the in-kernel ACPI should probably work for powerdown.


Regards: David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
