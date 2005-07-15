Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261824AbVGOWxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbVGOWxz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 18:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbVGOWxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 18:53:55 -0400
Received: from mo01.iij4u.or.jp ([210.130.0.20]:55531 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261824AbVGOWwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 18:52:55 -0400
Date: Sat, 16 Jul 2005 07:52:42 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm1
Message-Id: <20050716075242.24aed0bd.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20050715013653.36006990.akpm@osdl.org>
References: <20050715013653.36006990.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew

I got the following error.

make ARCH=mips oldconfig
scripts/kconfig/conf -o arch/mips/Kconfig
drivers/video/Kconfig:7:warning: type of 'FB' redefined from 'boolean' to 'tristate'

file drivers/char/speakup/Kconfig already scanned?
make[1]: *** [oldconfig] Error 1
make: *** [oldconfig] Error 2


gregkh-driver-speakup-core.patch

 arch/arm/Kconfig                         |    1
 arch/mips/Kconfig                        |    2
 arch/sparc64/Kconfig                     |    2

It is not necessary to change these three files. 
Please remove these changes.

Yoichi
