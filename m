Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265637AbTBXHqv>; Mon, 24 Feb 2003 02:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265675AbTBXHqu>; Mon, 24 Feb 2003 02:46:50 -0500
Received: from dp.samba.org ([66.70.73.150]:21948 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265637AbTBXHqt>;
	Mon, 24 Feb 2003 02:46:49 -0500
Date: Mon, 24 Feb 2003 18:42:32 +1100
From: Anton Blanchard <anton@samba.org>
To: "Randy.Dunlap" <randy.dunlap@verizon.net>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] convert /proc/io{mem,ports} to seq_file
Message-ID: <20030224074232.GA15887@krispykreme>
References: <3E59BDA1.AE4D483A@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E59BDA1.AE4D483A@verizon.net>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This patch is to Linux 2.5.62.
> 
> This converts /proc/io{mem,ports} to the seq_file interface
> (single_open).

Nice work! I have some machines that are very close to overflowing a
page:

4040 iomem
4082 ioports

Anton
