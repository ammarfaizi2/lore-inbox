Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265608AbUAQKjE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 05:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265809AbUAQKjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 05:39:04 -0500
Received: from albireo.ucw.cz ([81.27.194.19]:59520 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S265608AbUAQKjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 05:39:03 -0500
Date: Sat, 17 Jan 2004 11:39:00 +0100
From: Martin Mares <mj@ucw.cz>
To: Kieran Morrissey <linux@mgpenguin.net>
Cc: greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.1: Update PCI Name database, fix gen-devlist.c for long device names.
Message-ID: <20040117103859.GA2185@ucw.cz>
References: <5.1.0.14.2.20040115140515.00af1318@mail.mgpenguin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20040115140515.00af1318@mail.mgpenguin.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> * Updates pci.ids with a snapshot from http://pciids.sourceforge.net/ as at 
> 14 Jan 04.
> * Fixes gen-devlist.c to truncate long device names rather than reject the 
> whole database
>   (previously the latest databases had some devices that were too long and 
> caused a kernel with the latest db to fail to compile)

I think it would be better to increase the name length limit, the long entries
really have useful information at the end :)

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
