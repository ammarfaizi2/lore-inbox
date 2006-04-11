Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWDKLFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWDKLFK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 07:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbWDKLFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 07:05:10 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:56461 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750741AbWDKLFI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 07:05:08 -0400
Date: Tue, 11 Apr 2006 13:05:03 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: lkml <linux-kernel@vger.kernel.org>, zippel@linux-m68k.org
Subject: Re: [RFC/POC] multiple CONFIG y/m/n
In-Reply-To: <20060406224134.0430e827.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.61.0604111303131.928@yvahk01.tjqt.qr>
References: <20060406224134.0430e827.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>In doing lots of kernel build testing, I often want to enable all options
>in a sub-menu and their sub-sub-menus.  Sound is one of the worst^W longest
>of these, so I chose a shorter (easier) one to practice on:  parport.
>[..]
>I can already see that I find this useful, but is there a good (better)
>way to implement this in kconfig?
>[..]
>Comments?

I would like this one, for menuconfig (ncurses):

  'y', 'm' and 'n' have their usual behavior
  'Y', 'M' and 'N' affect the current item plus any subparts (if any)

That is, press *Shift*-Y/M/N for the "deep change".


Jan Engelhardt
-- 
