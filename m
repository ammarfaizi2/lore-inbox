Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264281AbTGKQrh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 12:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264328AbTGKQrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 12:47:37 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:4822
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S264281AbTGKQrf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 12:47:35 -0400
Date: Fri, 11 Jul 2003 13:02:18 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
Message-ID: <20030711170218.GH2210@gtf.org>
References: <20030711155843.GD2210@gtf.org> <Pine.SOL.4.30.0307111809500.17195-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0307111809500.17195-100000@mion.elka.pw.edu.pl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 06:23:32PM +0200, Bartlomiej Zolnierkiewicz wrote:
> How userspace component can help if you have ie. On-Track DM
> on your boot device?

initrd (now) or initramfs (future).

I would love to move all partition table (this includes raid
superblocks) into userspace, and device mapper makes this possible.


> I think you missed my point :-).
> 
> I think if somebody adds On-Track and EZ auto-detection to device mapper
> I can safely remove these ide boot options...

Agreed.

	Jeff



