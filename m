Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265976AbUBPXou (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 18:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265993AbUBPXot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 18:44:49 -0500
Received: from mail.kroah.org ([65.200.24.183]:60887 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265976AbUBPXos (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 18:44:48 -0500
Date: Mon, 16 Feb 2004 15:39:11 -0800
From: Greg KH <greg@kroah.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] move CONFIG_HOTPLUG to kernel/Kconfig.hotplug
Message-ID: <20040216233911.GB23911@kroah.com>
References: <200402150157.05808.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402150157.05808.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 15, 2004 at 01:57:05AM +0100, Bartlomiej Zolnierkiewicz wrote:
> 
> I've also noticed that some archs (cris, h8300, m68k and sparc) don't
> have HOTPLUG in their Kconfig files, shame on you - no udev for you 8).
> 
> BTW maybe HOTPLUG should be moved from "Bus options" to "General setup"?

I agree, it should go there, as it affects so much more these days than
"bus options".

Care to make that change instead?

thanks,

greg k-h
