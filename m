Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263609AbUFFNbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263609AbUFFNbO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 09:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263612AbUFFNbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 09:31:14 -0400
Received: from astro.futurequest.net ([69.5.28.104]:26248 "HELO
	astro.futurequest.net") by vger.kernel.org with SMTP
	id S263609AbUFFNbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 09:31:11 -0400
From: Daniel Schmitt <pnambic@unu.nu>
To: ktech@wanadoo.es
Subject: Re: 2.6.7-rc1 breaks forcedeth
Date: Sun, 6 Jun 2004 15:31:45 +0200
User-Agent: KMail/1.6.2
References: <E1BWxTh-0002dx-KR@mb06.in.mad.eresmas.com>
In-Reply-To: <E1BWxTh-0002dx-KR@mb06.in.mad.eresmas.com>
Cc: manfred@colorfullife.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406061531.45891.pnambic@unu.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Daniel, how do you fix or suggest to fix that? Any way I can get my network
> card on, in your opinion?

if what I suspect about MY problem is in fact true, then for your problem I'd 
try the following:

 - switch on APIC and IO-APIC support on uniprocessors in your kernel config
 - if there is such a setting, switch on APIC mode in your BIOS
 - see if this suffices (your dmesg output seems more sane than mine)

If the problem doesn't go away, try the patch at the top of my mail. If it 
still doesn't work, well, I might be completely wrong, or you might also be 
suffering from BIOS and/or DSDT problems, but I'm even more out of my depth 
there than with the issue I saw...

Good luck,

Daniel.
