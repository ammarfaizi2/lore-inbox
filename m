Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263457AbUJ3DIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263457AbUJ3DIz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 23:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbUJ3DIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 23:08:55 -0400
Received: from zone3.gcu-squad.org ([217.19.50.74]:52747 "EHLO
	zone3.gcu-squad.org") by vger.kernel.org with ESMTP id S263459AbUJ3DIp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 23:08:45 -0400
Date: Fri, 29 Oct 2004 09:34:12 +0200 (CEST)
To: bunk@stusta.de, chrisg@0-in.com, greg@kroah.com
Subject: Re: [2.6 patch] i2c it87.c: remove an unused function
X-IlohaMail-Blah: khali@gcu.info
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.13 (On: webmail.gcu.info)
Message-ID: <5qqD8rRk.1099035252.6524190.khali@gcu.info>
In-Reply-To: <20041029001745.GI29142@stusta.de>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Adrian & all,

> The patch below removes an unused function from drivers/i2c/chips/it87.c
> (...)
> -static inline void
> -superio_outb(int reg, int val)

For information, this function was most likely there for the case we
would implement the force_addr module parameter for this driver (see the
w83627hf driver in the same directory for an example of that).

That said, I have no objection to the removal of this function. We can
still add it back later if we ever need it.

Thanks,
Jean
