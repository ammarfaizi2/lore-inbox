Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261953AbVEIAkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbVEIAkR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 20:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263018AbVEIAkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 20:40:16 -0400
Received: from aun.it.uu.se ([130.238.12.36]:59852 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261953AbVEIAkN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 20:40:13 -0400
Date: Mon, 9 May 2005 02:40:01 +0200 (MEST)
Message-Id: <200505090040.j490e19v012839@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ak@muc.de
Subject: Re: [PATCH 2.6.12-rc3-mm3] perfctr: x86 update with K8 multicore fixes
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How about you just check cpu_core_map[] instead of adding your
> own custom detection code for this? This seems quite bogus to me.

Because these <whatever>map[]s are poorly documented, change
(get added or removed), and don't always exist in all subarchs.

I've been burned by cpu-related maps changing before. I'd rather
not rely on them if I can avoid them.

/Mikael
