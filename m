Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422749AbWJ3Xa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422749AbWJ3Xa3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 18:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161545AbWJ3Xa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 18:30:29 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:54962 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1161544AbWJ3Xa2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 18:30:28 -0500
Date: Tue, 31 Oct 2006 00:25:13 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tmattox@gmail.com, spiky.kiwi@gmail.com, r.bhatia@ipax.at
Subject: Re: r8169 mac address change (was Re: [0/3] 2.6.19-rc2: known regressions)
Message-ID: <20061030232513.GA6038@electric-eye.fr.zoreil.com>
References: <20061029223410.GA15413@electric-eye.fr.zoreil.com> <Pine.LNX.4.60.0610300032190.1435@poirot.grange> <20061030120158.GA28123@electric-eye.fr.zoreil.com> <Pine.LNX.4.60.0610302148560.9723@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0610302148560.9723@poirot.grange>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guennadi Liakhovetski <g.liakhovetski@gmx.de> :
[...]
> doesn't get printed. If I uncomment __rtl8169_set_mac_addr it stops 
> working again. What does it tell us about the original set_mac_address 
> problem?

Probably that it is issued too early/bluntly. I'll redo it later.

[...]
> The kernel is not 2.6.19-rc3 either. It is a clone of the powerpc git some 
> time shortly after 2.6.19-rc2.

You miss 73f5e28b336772c4b08ee82e5bf28ab872898ee1 and
733b736c91dd2c556f35dffdcf77e667cf10cefc. It should not matter.

-- 
Ueimor
