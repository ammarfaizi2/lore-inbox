Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265101AbUGZJi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265101AbUGZJi0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 05:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265108AbUGZJi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 05:38:26 -0400
Received: from herkules.viasys.com ([194.100.28.129]:52864 "HELO
	mail.viasys.com") by vger.kernel.org with SMTP id S265101AbUGZJiY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 05:38:24 -0400
Date: Mon, 26 Jul 2004 12:38:20 +0300
From: Ville Herva <vherva@viasys.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Future devfs plans (sorry for previous incomplete message)
Message-ID: <20040726093820.GL16073@viasys.com>
Reply-To: vherva@viasys.com
References: <200407261737.i6QHbff04878@freya.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407261737.i6QHbff04878@freya.yggdrasil.com>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux herkules.viasys.com 2.4.25-rc2+mremap-unmap
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2004 at 10:37:41AM -0700, you [Adam J. Richter] wrote:
> 
> 	3. hardware that is incidentally plugged in, but which might not
> 	   be used in the current session from boot to shutdown.  With the
> 	   increasing popularity of USB and firewire, a user might have a
> 	   "webcam", a still digital camera, a digital video converter, a
> 	   flash reader, a printer, a scanner and an external disk that
> 	   happen attached to the computer's USB network, with the user
> 	   having no intention of using any of them during the current
> 	   session from boot to shutdown.  This way, the cost of leaving
> 	   some things plugged in for convenience is reduced.

Not only memory, but stability, too. Not all the most exotic USB drivers
etc. are stellar wrt. their stability. If the driver is not loaded unless
the device is used (as opposed to boot-time), it can make the system behave
more stable.


-- v -- 

v@iki.fi

