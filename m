Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263996AbTLOTAX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 14:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264093AbTLOTAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 14:00:22 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:52918 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S263996AbTLOTAP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 14:00:15 -0500
Date: Mon, 15 Dec 2003 19:58:36 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Marcus Blomenkamp <Marcus.Blomenkamp@epost.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: r8169 GigE driver problem, locks up 2.4.23 NFS subsystem
Message-ID: <20031215195836.A17449@electric-eye.fr.zoreil.com>
References: <20031213140106.A24017@electric-eye.fr.zoreil.com> <200312131440.28071.Marcus.Blomenkamp@epost.de> <20031214144055.A4664@electric-eye.fr.zoreil.com> <200312151124.15143.Marcus.Blomenkamp@epost.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200312151124.15143.Marcus.Blomenkamp@epost.de>; from Marcus.Blomenkamp@epost.de on Mon, Dec 15, 2003 at 11:24:15AM +0100
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcus Blomenkamp <Marcus.Blomenkamp@epost.de> :
[...]
> I added more dummy printks and intermediate result: it does not return from 
> function 'rtl8169_hw_phy_config()' 
> 
> This routine messes up the card itself, as a reset/reboot into 2.4 does not 
> revitalize it. I definitively have to power-cycle the machine.

Daube. Thanks for the work.

If you have some spare time, you can try the patches available at:
<URL:http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.0-test11-bk5>
(a README describes the order).
They will not fix the issue but I would not be too surprized if something
breaks before "rtl8169_hw_phy_config" appears.

I'll be away from my computer until wednesday evening.

--
Ueimor
