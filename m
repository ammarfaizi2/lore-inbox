Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265060AbUAYRuY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 12:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265061AbUAYRuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 12:50:24 -0500
Received: from colin2.muc.de ([193.149.48.15]:28934 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S265060AbUAYRuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 12:50:21 -0500
Date: 25 Jan 2004 18:48:37 +0100
Date: Sun, 25 Jan 2004 18:48:37 +0100
From: Andi Kleen <ak@muc.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Fabio Coatti <cova@ferrara.linux.it>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, Eric <eric@cisu.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
Message-ID: <20040125174837.GB16962@colin2.muc.de>
References: <200401232253.08552.eric@cisu.net> <200401251639.56799.cova@ferrara.linux.it> <20040125162122.GJ513@fs.tum.de> <200401251811.27890.cova@ferrara.linux.it> <20040125173048.GL513@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040125173048.GL513@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It seems use-funit-at-a-time breaks with distributions shipping a gcc
> 3.3 that supports -funit-at-a-time.

It works for me with the hammer branch gcc 3.3 with -funit-at-a-time.

Are you sure the exception table sorting patch was properly applied?

> Th patch below replaces use-funit-at-a-time.patch and uses 
> scripts/gcc-version.sh from add-config-for-mregparm-3-ng* to use 
> -funit-at-a-time only with gcc >= 3.4 .

I disagree with that change.

-Andi
