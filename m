Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264842AbTAAUfC>; Wed, 1 Jan 2003 15:35:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264956AbTAAUfB>; Wed, 1 Jan 2003 15:35:01 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:5568 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S264842AbTAAUfB>; Wed, 1 Jan 2003 15:35:01 -0500
Date: Wed, 1 Jan 2003 21:43:25 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH,RFC] move CONFIG_NET to net/Kconfig
Message-ID: <20030101204325.GB17053@louise.pinerecords.com>
References: <20030101193229.GN15200@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030101193229.GN15200@louise.pinerecords.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The best part of this patch is that it eliminates a lot of duplicit
> stuff in 15 arch-specific files (only sparc32 and m68k define their
> net devices in an arch specific Kconfig) and places a single 'source
> "drivers/net/Kconfig"' line in the one file where it belongs, net/Kconfig.

Of course I could move sparc32 and m68k specific net devices to
drivers/net/Kconfig as well.

-- 
Tomas Szepe <szepe@pinerecords.com>
