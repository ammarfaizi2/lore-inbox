Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263451AbTFPG7q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 02:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbTFPG7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 02:59:46 -0400
Received: from ns.suse.de ([213.95.15.193]:3849 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263451AbTFPG7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 02:59:45 -0400
To: mikpe@csd.uu.se
Cc: linux-kernel@vger.kernel.org
Subject: Re: perfctr-2.5.5 released
References: <200306152229.h5FMTa93026063@harpo.it.uu.se.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 16 Jun 2003 09:13:34 +0200
In-Reply-To: <200306152229.h5FMTa93026063@harpo.it.uu.se.suse.lists.linux.kernel>
Message-ID: <p73d6he4hr5.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mikpe@csd.uu.se writes:

> Version 2.5.5 of perfctr, the Linux/x86 performance
> monitoring counters driver, is now available at the usual
> place: http://www.csd.uu.se/~mikpe/linux/perfctr/
> 
> x86-64 users please note that the 2.5.71 kernel won't
> compile on x86-64 due to incomplete 'driver model' changes.

Hmm? It compiles just fine here even without any patches
with the defconfig. Ok there are some warnings, but these can be 
safely ignored.

(or at least 2.5.71 did, current -bk doesn't again
because someone changed settimeofday without fixing the ports
correctly) 

Of course you are usually better off when you apply the current
patchkit from ftp://ftp.x86-64.org/pub/linux/v2.5/

> A patch to fix this and two other x86-64 bugs is in the
> patch-x86_64-2.5.71 file in perfctr's download directory.

When you fix x86-64 bugs you should submit the patches.

-Andi
