Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264891AbUD2Qma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264891AbUD2Qma (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 12:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264893AbUD2Qma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 12:42:30 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:12474 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264891AbUD2Qm2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 12:42:28 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Randy.Dunlap" <rddunlap@osdl.org>, Tom Rini <trini@kernel.crashing.org>
Subject: Re: [PATCH] Kconfig.debug family
Date: Thu, 29 Apr 2004 18:42:23 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, jgarzik@pobox.com,
       mpm@selenic.com, zwane@linuxpower.ca
References: <20040421205140.445ae864.rddunlap@osdl.org> <20040426164252.GA19246@smtp.west.cox.net> <20040429083820.6457fa84.rddunlap@osdl.org>
In-Reply-To: <20040429083820.6457fa84.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404291842.23968.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 of April 2004 17:38, Randy.Dunlap wrote:
> On Mon, 26 Apr 2004 09:42:52 -0700 Tom Rini wrote:
> | On Wed, Apr 21, 2004 at 08:51:40PM -0700, Randy.Dunlap wrote:
> | > Localizes kernel debug options in lib/Kconfig.debug.
> | > Puts arch-specific debug options in $ARCH/Kconfig.debug.
> |
> | [snip]
> |
> | >  arch/ppc/Kconfig             |  124 -------------------------
> | >  arch/ppc/Kconfig.debug       |   71 ++++++++++++++
> |
> | OCP shouldn't be moved into Kconfig.debug, it's just in an odd location
> | right now.
>
> Thanks.  I moved it to under Processor options, before Platform
> options.  Is that OK?
>
> Updated patch is here:
>   http://developer.osdl.org/rddunlap/patches/kdebug1file_266rc2_v2.patch
> (applies to 2.6.6-rc3 with a few offsets)
>
> Waiting for 2.6.6-final...

I guess it is not a final patch?

Only on x86 it does a proper thing:

arch/<arch>/Kconfig -> arch/<arch>/Kconfig.debug -> lib/Kconfig.debug

Cheers,
Bartlomiej

