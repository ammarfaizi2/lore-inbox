Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbTIHNIB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 09:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbTIHNIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 09:08:01 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:41602 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262275AbTIHNH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 09:07:59 -0400
Subject: Re: Hardware supported by the kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: DervishD <raul@pleyades.net>, Ch & Ph Drapela <pcdrap@bluewin.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030908095357.GD10358@redhat.com>
References: <3F59DF81.8000407@bluewin.ch> <20030906134029.GE69@DervishD>
	 <20030907223258.GE28927@redhat.com> <20030908092952.GA51@DervishD>
	 <20030908095357.GD10358@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063026380.21084.24.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Mon, 08 Sep 2003 14:06:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-09-08 at 10:53, Dave Jones wrote:
> SiS    - Cards like the Xabre are quite cheap, though unsupported,
>          though SiS folks did seemto wnat to help at one point, then
>          when quiet.

SiS have also since spun off their graphics division. Someone is porting
the SiS drivers to current DRI at the moment.

> S3     - Again, poorly performing, specs/drivers are out there.

Drivers for 4.2 release by VIA need porting to 4.3

> who did I miss ?

Trident - documentation is public, nobody has tackled a driver

Intel - older stuff is slow, newer onboard video is actually pretty good
and Intel support this stuff seriously. Its not a radeon but it players
cube perfectly well 8) Presumably intel will eventually fuse the CPU and
graphics into one chip.

VIA - XFree 4.2 drivers need porting over to 4.3. Original 4.2 code
provided by VIA. I've got glxgears kind of working but didnt have time
to go further and fix the span bugs and the locking v acceleration.


