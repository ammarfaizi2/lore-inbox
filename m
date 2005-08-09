Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbVHIAsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbVHIAsg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 20:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbVHIAsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 20:48:36 -0400
Received: from NS6.Sony.CO.JP ([137.153.0.32]:7835 "EHLO ns6.sony.co.jp")
	by vger.kernel.org with ESMTP id S932388AbVHIAsf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 20:48:35 -0400
Date: Tue, 09 Aug 2005 09:43:49 +0900 (JST)
Message-Id: <20050809.094349.112599262.kaminaga@sm.sony.co.jp>
To: arnd@arndb.de
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, kaminaga@sm.sony.co.jp
Subject: Re: [HELP] How to get address of module
From: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
In-Reply-To: <200508081530.54180.arnd@arndb.de>
References: <20050808214822.531ee849.sfr@canb.auug.org.au>
	<20050808.210645.78734846.kaminaga@sm.sony.co.jp>
	<200508081530.54180.arnd@arndb.de>
X-Mailer: Mew version 4.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [HELP] How to get address of module
Date: Mon, 8 Aug 2005 15:30:53 +0200

> You can do all that with module_address_lookup() using the KALLSYMS
> infrastructure.

Thank you.

What I wanted is: given the segfault address, I would like to 

1) get which module it is in
2) in that module, within which function it segfaulted

module_address_lookup would do!

HK.
--
