Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270069AbUJHR2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270069AbUJHR2W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 13:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270071AbUJHR2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 13:28:22 -0400
Received: from 208.177.141.226.ptr.us.xo.net ([208.177.141.226]:53851 "HELO
	ash.lnxi.com") by vger.kernel.org with SMTP id S270067AbUJHR2K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 13:28:10 -0400
Subject: Re: 2.6 noisy boot messages from gen_probe.c
From: Thayne Harbaugh <tharbaugh@lnxi.com>
Reply-To: tharbaugh@lnxi.com
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: linux-kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <4165DD2C.1050209@eyal.emu.id.au>
References: <4165DD2C.1050209@eyal.emu.id.au>
Content-Type: text/plain
Organization: Linux Networx
Date: Fri, 08 Oct 2004 11:07:31 -0600
Message-Id: <1097255252.29953.26.camel@tubarao>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 (1.5.94.1-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-08 at 10:19 +1000, Eyal Lebedinsky wrote:
> I get this stuff at bootup, and I do not see why it should
> interest me. Normally one wants to see only detected devices
> and not failed probes. I did not enable any debug option
> in the kernel.
> 
> It seems to come from
> 	mtd/chips/gen_probe.c
> I do have
> 	CONFIG_MTD_ICHXROM=m
> because I build all modules. So, should these printk's really
> be KERN_WARNING or should they be removed?
> 
> Oct  8 09:58:45 eyal kernel: hub 5-0:1.0: 8 ports detected
> Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
> Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero

<SNIP>

You'll get better response if you CC your message to those that are most
interested.  Check the MAINTAINERS file:

MEMORY TECHNOLOGY DEVICES
P:      David Woodhouse
M:      dwmw2@redhat.com
W:      http://www.linux-mtd.infradead.org/
L:      linux-mtd@lists.infradead.org
S:      Maintained



