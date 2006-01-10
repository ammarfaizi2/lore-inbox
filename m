Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbWAJBXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWAJBXI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 20:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751811AbWAJBXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 20:23:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21978 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750853AbWAJBXH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 20:23:07 -0500
Date: Mon, 9 Jan 2006 17:22:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alexander Gran <alex@zodiac.dnsalias.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm2
Message-Id: <20060109172251.0c457a95.akpm@osdl.org>
In-Reply-To: <200601100130.12227@zodiac.zodiac.dnsalias.org>
References: <20060107052221.61d0b600.akpm@osdl.org>
	<200601080139.34774@zodiac.zodiac.dnsalias.org>
	<20060107175056.3d7a2895.akpm@osdl.org>
	<200601100130.12227@zodiac.zodiac.dnsalias.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Gran <alex@zodiac.dnsalias.org> wrote:
>
> Am Sonntag, 8. Januar 2006 02:50 schrieben Sie:
> > Can you try removing EDAC from .config?
> 
> Just did.
> 
> > I doubt if the cause is EDAC really.  If you could investigate a bit
> > further it'd help.  mtrr?  Run top?  Generate a kernel profile?  Is it just
> > X being sluggish?  (DRM/AGP?) etc.
> 
> 
> EDAC errors are gone. System isn't sluggish ;)

You're saying that enabling the EDAC driver made the system sluggish?

Did you look at the `top' output, or generate a kernel profile?  That would
really help.

> However one new erro:
> serial8250: too much work for irq3
> serial8250: too much work for irq3

Was the serial port in use at the time?  Does it work?
