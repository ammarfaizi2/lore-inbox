Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269007AbUJKOWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269007AbUJKOWU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 10:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268993AbUJKOWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 10:22:19 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:26817 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269007AbUJKOVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 10:21:42 -0400
Subject: Re: MMC performance
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041011131919.B19175@flint.arm.linux.org.uk>
References: <416A68E5.6080608@drzeus.cx>
	 <20041011131919.B19175@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097500722.31259.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 11 Oct 2004 14:18:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-10-11 at 13:19, Russell King wrote:
> Only if you can reliably know how many bytes you've tranferred when
> an error occurs.  Without that, the only safe way to do a write is
> sector by sector.

Only on retries. You can try and blast the lot out the first time then
on retries you write sector by sector.


