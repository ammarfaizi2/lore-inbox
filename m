Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265930AbTIER6e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 13:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265935AbTIER6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 13:58:34 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51718 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265930AbTIER6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 13:58:31 -0400
Date: Fri, 5 Sep 2003 18:58:19 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Sven Dowideit <svenud@ozemail.com.au>
Cc: Daniel Ritz <daniel.ritz@gmx.ch>, Tom Marshall <tommy@home.tig-grr.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problems with PCMCIA (Texas Instruments PCI1450)
Message-ID: <20030905185819.B14076@flint.arm.linux.org.uk>
Mail-Followup-To: Sven Dowideit <svenud@ozemail.com.au>,
	Daniel Ritz <daniel.ritz@gmx.ch>,
	Tom Marshall <tommy@home.tig-grr.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200308270056.33190.daniel.ritz@gmx.ch> <20030827135940.A31850@flint.arm.linux.org.uk> <1062798822.631.11.camel@sven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1062798822.631.11.camel@sven>; from svenud@ozemail.com.au on Sat, Sep 06, 2003 at 07:53:42AM +1000
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 06, 2003 at 07:53:42AM +1000, Sven Dowideit wrote:
> On Wed, 2003-08-27 at 22:59, Russell King wrote:
> > I've just created http://pcmcia.arm.linux.org.uk/ to document the
> > currently known problems and to contain patches for them.
> > 
> ok, I've built and booted linux 2.5.70 to 2.5.75, and it seems that the
> detecting the aironet card as a memory_cs device happens in 2.5.74

Ok, there's two sets of changes between .73 and .74 which touch PCMCIA.
The first is 2.5.73-bk1-bk2 and the second is 2.5.73-bk8-bk9.

ftp.kernel.org:/pub/linux/kernel/v2.5/snapshots/incr/patch-2.5.73-bk1-bk2.bz2
ftp.kernel.org:/pub/linux/kernel/v2.5/snapshots/incr/patch-2.5.73-bk8-bk9.bz2

I'm not going to try to guess which caused the problem, but I'm intrigued
to know which is causing the problems.

Thanks for your efforts so far tracking the problem down.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
