Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267378AbTGZSlC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 14:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267471AbTGZSlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 14:41:02 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:27776
	"EHLO x30.random") by vger.kernel.org with ESMTP id S267378AbTGZSk7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 14:40:59 -0400
Date: Sat, 26 Jul 2003 14:55:51 -0400
From: Andrea Arcangeli <andrea@suse.de>
To: Manuel Estrada Sainz <ranty@debian.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: request_firmware() backport to 2.4 kernels
Message-ID: <20030726185551.GA5053@x30.random>
References: <20030726121638.GB31145@ranty.pantax.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030726121638.GB31145@ranty.pantax.net>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 26, 2003 at 02:16:38PM +0200, Manuel Estrada Sainz wrote:
>  Hi,
>  
>  A while back request_firmware() was added to the 2.5 kernel series to
>  support firmware needing drivers keeping the firmware images in
>  userspace. And I also backported it to the 2.4 kernel series on top of
>  procfs, but Marcelo didn't answer emails relating to it (there where
>  probably other more important matters back then).
>  
>  Since then, the 2.4 backport has been deployed and tested with
>  orinoco_usb driver variant (http://orinoco-usb.alioth.debian.org/),
>  as you can see in the download statistics in alioth, there has been
>  more than 400 downloads of the request_firmware enabled version
>  (0.2.1). And drivers on the 2.5/2.6 series are being ported to use
>  request_firmware() interface.
> 
>  Would it be possible to include it in the -aa kernel tree? That would
>  make it accessible to a wider audience for testing, and make it easier
>  for developers to backport their drivers to the 2.4
>  series.
> 
>  Attached goes the patch against current 2.4-bk-cvs.

it's not intrusive, so I can certainly include it in the meantime,
thanks.

>  Have a nice day

same to you ;)

Andrea
