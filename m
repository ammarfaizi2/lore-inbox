Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264604AbUBEK61 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 05:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264605AbUBEK60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 05:58:26 -0500
Received: from mail.bbb2.mdc-berlin.de ([141.80.34.25]:56081 "EHLO
	mail.bbb2.mdc-berlin.de") by vger.kernel.org with ESMTP
	id S264604AbUBEK5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 05:57:48 -0500
Subject: linux-2.6.2-mm1 and can't open file "drivers/pnp/isapnp/Kconfig
From: Juergen Rose <rose@rz.uni-potsdam.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Max-Delbrueck-Zentrum
Message-Id: <1075978665.14000.28.camel@moen.bioinf.mdc-berlin.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 05 Feb 2004 11:57:46 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I can't configure linux-2.6.2-mm1, because a missing
drivers/pnp/isapnp/Kconfig. I patched a plain linux-2.6.2 with
2.6.2-mm1.bz2 from
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2/2.6.2-mm1/

vilm:/usr/src/linux(40)#make menuconfig
make[1]: `scripts/fixdep' is up to date.
scripts/kconfig/mconf arch/i386/Kconfig
drivers/pnp/Kconfig:34: can't open file "drivers/pnp/isapnp/Kconfig"
make[1]: *** [menuconfig] Error 1

Any hint how to manage this problem, especially without bk, would be
very helpfull.

	Regards Juergen

P.S. Please send answers also to my email address.

-- 
Juergen Rose <rose@rz.uni-potsdam.de>
Max-Delbrueck-Zentrum

