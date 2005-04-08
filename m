Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVDHX0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVDHX0T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 19:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVDHX0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 19:26:19 -0400
Received: from mail.dif.dk ([193.138.115.101]:6029 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261186AbVDHX0P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 19:26:15 -0400
Date: Sat, 9 Apr 2005 01:28:47 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm2
In-Reply-To: <20050408030835.4941cd98.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0504090125171.2455@dragon.hyggekrogen.localhost>
References: <20050408030835.4941cd98.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Apr 2005, Andrew Morton wrote:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm2/
> 

Still doesn't build for me with my usual config (available upon request) 
unless I enable ACPI :

...
  CC      arch/i386/kernel/setup.o
arch/i386/kernel/setup.c:96: error: parse error before "acpi_sci_flags"
arch/i386/kernel/setup.c:96: warning: type defaults to `int' in declaration of `acpi_sci_flags'
arch/i386/kernel/setup.c:96: warning: data definition has no type or storage class
arch/i386/kernel/setup.c: In function `parse_cmdline_early':
arch/i386/kernel/setup.c:811: error: request for member `trigger' in something not a structure or union
arch/i386/kernel/setup.c:814: error: request for member `trigger' in something not a structure or union
arch/i386/kernel/setup.c:817: error: request for member `polarity' in something not a structure or union
arch/i386/kernel/setup.c:820: error: request for member `polarity' in something not a structure or union
make[1]: *** [arch/i386/kernel/setup.o] Error 1
make: *** [arch/i386/kernel] Error 2



-- 
Jesper Juhl


