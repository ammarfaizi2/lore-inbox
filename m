Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289198AbSBDWNr>; Mon, 4 Feb 2002 17:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289211AbSBDWNg>; Mon, 4 Feb 2002 17:13:36 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27920 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289198AbSBDWNV>; Mon, 4 Feb 2002 17:13:21 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: How to check the kernel compile options ?
Date: 4 Feb 2002 14:12:57 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a3n119$gbp$1@cesium.transmeta.com>
In-Reply-To: <3C5EB070.4370181B@uni-mb.si> <3C5EB070.4370181B@uni-mb.si> <4.3.2.7.2.20020204124812.00aec590@mail.osagesoftware.com> <4.3.2.7.2.20020204133252.00c50f00@mail.osagesoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <4.3.2.7.2.20020204133252.00c50f00@mail.osagesoftware.com>
By author:    David Relson <relson@osagesoftware.com>
In newsgroup: linux.dev.kernel
> 
> >I have had in my /sbin/installkernel a clause to save .config as
> >config-<foo> when I install vmlinuz-<foo>; I believe anyone not doing
> >that[1] is, quite frankly, a moron.
> 
> Why not a simple patch for "make install" to do this?
> 

Good thought.  I was waiting for the various kernel build changes in
2.5 to overhaul make install, but a small thing should be doable in
2.4.  Note that if you have an /sbin/installkernel it overrides make
install -- as it should be.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
