Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750864AbWJ3MG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWJ3MG7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 07:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbWJ3MG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 07:06:58 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:36994 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1750864AbWJ3MG5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 07:06:57 -0500
Date: Mon, 30 Oct 2006 13:01:58 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tmattox@gmail.com, spiky.kiwi@gmail.com, r.bhatia@ipax.at
Subject: Re: r8169 mac address change (was Re: [0/3] 2.6.19-rc2: known regressions)
Message-ID: <20061030120158.GA28123@electric-eye.fr.zoreil.com>
References: <20061029223410.GA15413@electric-eye.fr.zoreil.com> <Pine.LNX.4.60.0610300032190.1435@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0610300032190.1435@poirot.grange>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guennadi Liakhovetski <g.liakhovetski@gmx.de> :
[...]
> AFAIU, you wanted it applied on the top of the "non-working" kernel 
> (2.6.19-rc2-ish)?

No. Please apply it on top of a 2.6.19-rc3 where the mac address change
feature has been reverted (or where __rtl8169_set_mac_addr has been
commented out at your option). 

[...]
> dmesg when it didn't work (I do use netconsole, don't think it matters?):

I'd rather fix everything else without netconsole first. It will make
my life simpler.

-- 
Ueimor
