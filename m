Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267596AbUHTGcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267596AbUHTGcp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 02:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267597AbUHTGcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 02:32:45 -0400
Received: from poros.telenet-ops.be ([195.130.132.44]:23987 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S267596AbUHTGcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 02:32:43 -0400
Date: Fri, 20 Aug 2004 08:32:56 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] add missing watchdog COMPATIBLE_IOCTLs
Message-ID: <20040820063255.GF4908@infomag.infomag.iguana.be>
References: <200408031851.40923.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408031851.40923.arnd@arndb.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

> The watchdog ioctl interface is defined correctly for 32 bit emulation,
> although WIOC_GETSUPPORT was not marked as such, for an unclear reason.
> WDIOC_SETTIMEOUT and WDIOC_GETTIMEOUT were added in may 2002 to the
> code but never to the ioctl list. This adds all three definitions.

This is indeed correct. We should add them. I can't test it myself because
I have no 64 bit system...

Anyway: I included it in "my watchdog tree" so that it can be merged into
the kernel.

Thanks,
Wim.

