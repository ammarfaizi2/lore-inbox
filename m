Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbWGJLFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWGJLFE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 07:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbWGJLFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 07:05:04 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:26596 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S964805AbWGJLFB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 07:05:01 -0400
Date: Mon, 10 Jul 2006 13:04:32 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, nickpiggin@yahoo.com.au,
       dwmw2@infradead.org, tglx@linutronix.de, arjan@infradead.org,
       rmk+lkml@arm.linux.org.uk
Subject: Re: AVR32 architecture patch against Linux 2.6.18-rc1 available
Message-ID: <20060710130432.12787501@cad-250-152.norway.atmel.com>
In-Reply-To: <20060710023758.986a91e9.akpm@osdl.org>
References: <20060706105227.220565f8@cad-250-152.norway.atmel.com>
	<20060706021906.1af7ffa3.akpm@osdl.org>
	<20060706120319.26b35798@cad-250-152.norway.atmel.com>
	<20060706031416.33415696.akpm@osdl.org>
	<20060710110325.3b9a8270@cad-250-152.norway.atmel.com>
	<20060710023758.986a91e9.akpm@osdl.org>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2006 02:37:58 -0700
Andrew Morton <akpm@osdl.org> wrote:

> On Mon, 10 Jul 2006 11:03:25 +0200
> Haavard Skinnemoen <hskinnemoen@atmel.com> wrote:
> 
> > I've put up an updated patch at
> > http://avr32linux.org/twiki/pub/Main/LinuxPatches/avr32-arch-3.patch
> 
> That diff doesn't update ./MAINTAINERS

Crap, I can't belive I left that out two times in a row...

> Please prepare a nice changelog describing the architecture (what's an
> avr?), who supports it, useful web pages, how to build cross-tools,
> etc. The sort of things which Linus and kernel developers should know
> when someone sends in a half-megabyte patch.
>
> And a signed-off-by:, as per section 11 of
> Documentation/SubmittingPatches.

Updated patch with MAINTAINERS, a much longer changelog entry and
Signed-off-by:

http://avr32linux.org/twiki/pub/Main/LinuxPatches/avr32-arch-4.patch

By the way, there's a separate patch #ifdef'ing out /dev/port available
from the same LinuxPatches page. Should I fold it into the avr32-arch
patch? I don't consider this a permanent solution anyway, so I made it
a separate patch in order to drop it more easily when we actually
implement port-based I/O...

Thanks,
Håvard
