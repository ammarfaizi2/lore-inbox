Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132516AbREENyq>; Sat, 5 May 2001 09:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132527AbREENyd>; Sat, 5 May 2001 09:54:33 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:16147 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S132516AbREENyT>;
	Sat, 5 May 2001 09:54:19 -0400
Date: Sat, 5 May 2001 06:52:15 -0700
From: Anton Blanchard <anton@samba.org>
To: Matt Kemner <kemner@live.wasp.net.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: sparc: Run out of nocached RAM!
Message-ID: <20010505065214.B32232@va.samba.org>
In-Reply-To: <Pine.LNX.4.30.0105041009550.3666-100000@live.wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0105041009550.3666-100000@live.wasp.net.au>; from kemner@live.wasp.net.au on Fri, May 04, 2001 at 10:26:29AM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I run kernel 2.4.1 (from the Debian kernel-source-2.4.1-3 package) on an
> Axil 320 (Dual Hypersparc) with 320MB of RAM, which just died (full
> lockup) with the message "Run out of nocached RAM!" being the last message
> on the screen. 

Increase SRMMU_NOCACHE_NPAGES in include/asm-sparc/vaddrs.h (say 512 or
1024).

Anton
