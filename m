Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266018AbUFDVra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266018AbUFDVra (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 17:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266017AbUFDVra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 17:47:30 -0400
Received: from adsl-121-231.38-151.net24.it ([151.38.231.121]:43532 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S266018AbUFDVrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 17:47:23 -0400
Date: Fri, 4 Jun 2004 23:47:21 +0200
From: Daniele Venzano <webvenza@libero.it>
To: Nigel Kukard <nkukard@lbsd.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [HANG] SIS900 + P4 Hyperthread
Message-ID: <20040604214721.GC22679@picchio.gall.it>
Mail-Followup-To: Nigel Kukard <nkukard@lbsd.net>,
	linux-kernel@vger.kernel.org
References: <40C0E37C.4030905@lbsd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C0E37C.4030905@lbsd.net>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.25-grsec
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2004 at 09:02:52PM +0000, Nigel Kukard wrote:
> Hi,
> 
> Using kernel 2.6.6 on a m/b with an builtin sis900 network adapter i get 
> a soft hang during HEAVY network traffic (ie. 7.5Mb/s). I tried to 
> enable sysrq to no avail. Keyboard is still active but any attempt to 
> run any command hangs.
> 
> Disabling hyperthreading in the bios seems to solve the problem. I think 
> this is smp related.
Disabling support in the kernel at compile time makes any difference ?
Unfortunately I don't have any SMP hardware to try to reproduce this
problem.

> When using 2.4.x all is ok with hyperthreading enabled.
This is important. The driver has some differences between the two
versions, but none of them is releated to SMP. I'll chack again, but if
someone with some more smp-karma than me wants to join, he is most
welcome...
So I'm leaning towards blaming a problem outside the sis900 driver
itself.

Thanks.

-- 
-----------------------------
Daniele Venzano
Web: http://teg.homeunix.org

