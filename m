Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266959AbUBGPmG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 10:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266960AbUBGPmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 10:42:06 -0500
Received: from server1.bbb2.mdc-berlin.de ([141.80.34.10]:48913 "EHLO
	server1.bbb2.mdc-berlin.de") by vger.kernel.org with ESMTP
	id S266959AbUBGPmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 10:42:03 -0500
Subject: drivers/pnp/isapnp/Kconfig not found performing configure for
	linux-2.6.2-mm1
From: Juergen Rose <rose@rz.uni-potsdam.de>
To: Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Max-Delbrueck-Zentrum
Message-Id: <1076168521.24931.2.camel@moen.bioinf.mdc-berlin.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 07 Feb 2004 16:42:01 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I can't configure linux-2.6.2-mm1, because of a missing
drivers/pnp/isapnp/Kconfig. I patched a plain linux-2.6.2 with
2.6.2-mm1.bz2:

vilm:/usr/src/linux(40)#make menuconfig
make[1]: `scripts/fixdep' is up to date.
scripts/kconfig/mconf arch/i386/Kconfig
drivers/pnp/Kconfig:34: can't open file "drivers/pnp/isapnp/Kconfig"
make[1]: *** [menuconfig] Error 1

What can I do?

	Regards Juergen
-- 
Juergen Rose <rose@rz.uni-potsdam.de>
Max-Delbrueck-Zentrum

