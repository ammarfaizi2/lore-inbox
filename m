Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750895AbWGaPyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbWGaPyZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 11:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWGaPyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 11:54:25 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:30433 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750895AbWGaPyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 11:54:24 -0400
Subject: Re: PROBLEM: OSS/MAD16 not available to compilation of kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: erlk ozlr <erlk.ozlr@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1d950a40607310825n334789e8ma98eb29612c8fbf0@mail.gmail.com>
References: <1d950a40607310825n334789e8ma98eb29612c8fbf0@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 31 Jul 2006 17:13:23 +0100
Message-Id: <1154362403.7230.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-07-31 am 17:25 +0200, ysgrifennodd erlk ozlr:
> Hi,
> I'm using linux 2.6.17 and I want to compile the mad16 driver but "at
> least" CONFIG_SOUND_MAD16 is not present in "<source
> root>/sound/oss/Kconfig" which makes it unchoosable in the `make
> <something>config`, but there is still presence in the
> "/sound/oss/Makefile".

OSS is being stripped down to remove all the hardware that has been
supported for some years by ALSA as part of the migration to ALSA that
has been going on over time. The ALSA Opti 82C9xx chipset driver should
act as a replacement for MAD16.

