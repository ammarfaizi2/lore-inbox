Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161293AbWJ3Ln0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161293AbWJ3Ln0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 06:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWJ3Ln0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 06:43:26 -0500
Received: from brick.kernel.dk ([62.242.22.158]:52496 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S932448AbWJ3LnZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 06:43:25 -0500
Date: Mon, 30 Oct 2006 12:45:03 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Gregor Jasny <gjasny@googlemail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
Subject: Re: 2.6.19-rc3 system freezes when ripping with cdparanoia at ioctl(SG_IO)
Message-ID: <20061030114503.GW4563@kernel.dk>
References: <9d2cd630610291120l3f1b8053i5337cf3a97ba6ff0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d2cd630610291120l3f1b8053i5337cf3a97ba6ff0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29 2006, Gregor Jasny wrote:
> Hi,
> 
> Today I tried the new cdparanoia from Debian Sid (3.10+debian~pre0-2).
> When I started ripping with "cdparanoia -d /dev/scd0 1" my system
> freezes after some seconds. There is no oops and even the console
> cursor stops blinking.
> 
> If I start cdparanoia with -g /dev/scd0 it starts ripping and but the
> kernel prints many "program cdparanoia not setting count and/or
> reply_len properly" warnings. But this seems to be a cdparanoia bug.
> 
> My CDROM:
> Vendor:                    PIONEER
> Product:                   DVD-ROM DVD-106
> Revision level:            1.22

Can you confirm that 2.6.18 works?

-- 
Jens Axboe

