Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbVHHNhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbVHHNhi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 09:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbVHHNhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 09:37:38 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:1248 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750873AbVHHNhi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 09:37:38 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Subject: Re: [HELP] How to get address of module
Date: Mon, 8 Aug 2005 15:30:53 +0200
User-Agent: KMail/1.7.2
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org
References: <20050808.204022.30161255.kaminaga@sm.sony.co.jp> <20050808214822.531ee849.sfr@canb.auug.org.au> <20050808.210645.78734846.kaminaga@sm.sony.co.jp>
In-Reply-To: <20050808.210645.78734846.kaminaga@sm.sony.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200508081530.54180.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maandag 08 August 2005 14:06, Hiroki Kaminaga wrote:

> If the cause is in some insmod'ed module, then I would like to get
> info of that module. If I get the address of that module, I can get
> info such as symbol name defined by that module, etc. Then I could say
> in module mmm, at func fff, at addr xxx, there is segfault.

You can do all that with module_address_lookup() using the KALLSYMS
infrastructure.

	Arnd <><
