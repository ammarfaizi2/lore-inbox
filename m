Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbUC1Uh6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 15:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbUC1Uh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 15:37:57 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43232 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261924AbUC1Uhp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 15:37:45 -0500
Message-ID: <4067378B.7070102@pobox.com>
Date: Sun, 28 Mar 2004 15:37:31 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: silverbanana@gmx.de
CC: linux-kernel@vger.kernel.org
Subject: Re: usage of RealTek 8169 crashes my Linux system
References: <40673495.3050500@gmx.de>
In-Reply-To: <40673495.3050500@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Fuhrmann wrote:
> Hi!
> 
> I'm using a RealTek 8169 1000MBit NIC. However, whenever larger amounts 
> of data are being transfered (copying files through smb for instance) 
> Linux crashes. It happens after 10MB-100MB transferred data so it's 
> never as stable as it should be. The whole System runs fine as long as 
> that Realtek 8169 NIC is not used (by transferring data through it). 
> When it crashes there is no entry for that event in kern.log and the 
> system just hangs.
> 
> I'm using:
> Linux 2.6.4
> gcc 3.3.3
> 2X Athlon MP 2600 Mhz
> Tyan Tiger S2466N-4M Dual / AMD760MPX
> 2x 512MB ECC/REG Infineon DDR PC266 RAM
> Debian (unstable)
> 
> Any idea how to fix it? Is that driver getting stable in the next months 
> or are there obstacles that should make me buy a different NIC (like 
> missing docs for that chipset and stuff like that)?


Does Andrew Morton's -mm patches fix it for you?

	Jeff



