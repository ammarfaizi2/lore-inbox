Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263466AbTLOKE1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 05:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263468AbTLOKE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 05:04:27 -0500
Received: from albireo.ucw.cz ([81.27.194.19]:36224 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S263466AbTLOKE0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 05:04:26 -0500
Date: Mon, 15 Dec 2003 11:04:25 +0100
From: Martin Mares <mj@ucw.cz>
To: Damien =?iso-8859-2?Q?Courouss=E9?= <damien.courousse@imag.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI lib for 2.4
Message-ID: <20031215100425.GA551@ucw.cz>
References: <A2ABB06A-2CD7-11D8-8839-00039344321E@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A2ABB06A-2CD7-11D8-8839-00039344321E@imag.fr>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm a rookie in Linux development, and I have to develop a small driver 
> for a data-acquisition card on PCI port.
> 
> My problem is that my compiler does not recognize some functions such as 
> 'pci_resource_start()', or 'pci_find_device()' ...

Is your driver a kernel module or a userspace program?

If it's a kernel module, you need to set the right CFLAGS (the same as the
kernel uses).

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
COBOL -- Completely Outdated, Badly Overused Language
