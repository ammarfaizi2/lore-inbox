Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755270AbWKRRpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755270AbWKRRpT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 12:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755276AbWKRRpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 12:45:18 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:29902 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1755270AbWKRRpR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 12:45:17 -0500
Date: Sat, 18 Nov 2006 18:42:31 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Toralf =?unknown-8bit?Q?F=C3=B6rster?= <toralf.foerster@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.19-rc6-ge030f829 build #131 failed
Message-ID: <20061118174231.GA9871@electric-eye.fr.zoreil.com>
References: <200611181805.00130.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200611181805.00130.toralf.foerster@gmx.de>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Toralf Förster <toralf.foerster@gmx.de> :
[...]
> WARNING: "hdlc_close" [drivers/net/wan/dscc4.ko] undefined!
> WARNING: "hdlc_open" [drivers/net/wan/dscc4.ko] undefined!
> WARNING: "alloc_hdlcdev" [drivers/net/wan/dscc4.ko] undefined!
> WARNING: "unregister_hdlc_device" [drivers/net/wan/dscc4.ko] undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2

Jeff has already applied a fix for it. See:

http://www.kernel.org/git/?p=linux/kernel/git/jgarzik/netdev-2.6.git;a=commit;h=5d11e6d1657b5170d8c31d71b21995c99388dbd0

-- 
Ueimor
