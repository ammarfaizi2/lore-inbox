Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265190AbSK1FVm>; Thu, 28 Nov 2002 00:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265196AbSK1FVm>; Thu, 28 Nov 2002 00:21:42 -0500
Received: from pizda.ninka.net ([216.101.162.242]:26785 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265190AbSK1FVk>;
	Thu, 28 Nov 2002 00:21:40 -0500
Date: Wed, 27 Nov 2002 21:27:23 -0800 (PST)
Message-Id: <20021127.212723.105417843.davem@redhat.com>
To: sfr@canb.auug.org.au
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, anton@samba.org,
       ak@muc.de, davidm@hpl.hp.com, schwidefsky@de.ibm.com, ralf@gnu.org,
       willy@debian.org
Subject: Re: [PATCH] Start of compat32.h (again)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021128000026.6bd71217.sfr@canb.auug.org.au>
References: <20021127184228.2f2e87fd.sfr@canb.auug.org.au>
	<20021126.235810.22015752.davem@redhat.com>
	<20021128000026.6bd71217.sfr@canb.auug.org.au>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Stephen Rothwell <sfr@canb.auug.org.au>
   Date: Thu, 28 Nov 2002 00:00:26 +1100
   
   This will be allowed for when linux/compat32.h includes asm/compat32.h
   at a later stage.  asm/compat32.h will be expected to have typedefs for
   compat32_<type> (or __kernel_<type>32 whatever) for all the types that
   vary between the architectures.

This sounds fine.
