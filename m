Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262338AbULMTyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262338AbULMTyB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 14:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbULMTwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 14:52:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:57266 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262281AbULMTkX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 14:40:23 -0500
Date: Mon, 13 Dec 2004 11:40:18 -0800
From: Chris Wright <chrisw@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Main <zefram@fysh.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kernel/capability.c: make a spinlock static
Message-ID: <20041213114018.M469@build.pdx.osdl.net>
References: <20041212191654.GV22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041212191654.GV22324@stusta.de>; from bunk@stusta.de on Sun, Dec 12, 2004 at 08:16:54PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Adrian Bunk (bunk@stusta.de) wrote:
> The patch below makes a needlessly global spinlock static.
> 
> 
> diffstat output:
>  include/linux/capability.h |    2 --
>  kernel/capability.c        |    4 ++--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Signed-off-by: Chris Wright <chrisw@osdl.org>

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
