Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964882AbWFXXCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbWFXXCW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 19:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbWFXXCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 19:02:22 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:14755 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964870AbWFXXCV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 19:02:21 -0400
Subject: Re: + via-pata-controller-xfer-fixes.patch added to -mm tree
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jeff@garzik.org>
Cc: akpm@osdl.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       castet.matthieu@free.fr, B.Zolnierkiewicz@elka.pw.edu.pl,
       htejun@gmail.com, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <449DBE88.5020809@garzik.org>
References: <200606242214.k5OMEHCU005963@shell0.pdx.osdl.net>
	 <449DBE88.5020809@garzik.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 25 Jun 2006 00:17:31 +0100
Message-Id: <1151191051.8676.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SETFEATURES_XFER stuff is magic anyway because some controllers snoop.
Also of course like the old IDE we send some rather iffy PIO requests
and that might have something to do with the problem of course.

I've got two reports that look similar and are from ALi controllers so
trying the 10uS version might be worth doing, at least for PATA

