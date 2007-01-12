Return-Path: <linux-kernel-owner+w=401wt.eu-S1750918AbXALPM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbXALPM6 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 10:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbXALPM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 10:12:58 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:4178 "EHLO
	tuxland.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750918AbXALPM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 10:12:58 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Frederik Deweerdt <deweerdt@free.fr>
Subject: Re: 2.6.20-rc4-mm1
Date: Fri, 12 Jan 2007 16:13:27 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       drzeus@drzeus.cx
References: <20070111222627.66bb75ab.akpm@osdl.org> <200701121125.58794.m.kozlowski@tuxland.pl> <20070112131800.GE5941@slug>
In-Reply-To: <20070112131800.GE5941@slug>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701121613.28254.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

> That's because mmc_lock_unlock should depend on CONFIG_KEYS, it uses struct key.
> Could you try the following patch (compile tested)?

Thanks. Compiles ok but now I run into another problem and the laptop doesn't boot.
The last thing I see is grub. So no way to test it now. Time to dig some more ;-)

-- 
Regards,

	Mariusz Kozlowski
