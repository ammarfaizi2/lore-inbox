Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265611AbUATRrg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 12:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265620AbUATRqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 12:46:12 -0500
Received: from ns.suse.de ([195.135.220.2]:22933 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265617AbUATRqG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 12:46:06 -0500
To: Gerd Knorr <kraxel@bytesex.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] -mm5 has no i2c on amd64
References: <20040120124626.GA20023@bytesex.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 20 Jan 2004 13:59:46 +0100
In-Reply-To: <20040120124626.GA20023@bytesex.org.suse.lists.linux.kernel>
Message-ID: <p73n08ihj25.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr <kraxel@bytesex.org> writes:
> 
> ==============================[ cut here ]==============================
> --- linux-mm5-2.6.1/arch/x86_64/Kconfig.i2c	2004-01-20 13:14:42.000000000 +0100
> +++ linux-mm5-2.6.1/arch/x86_64/Kconfig	2004-01-20 13:15:10.000000000 +0100
> @@ -429,6 +429,8 @@
>  
>  source "drivers/char/Kconfig"
>  
> +source "drivers/i2c/Kconfig"
> +

There is no such source in arch/i386/Kconfig.  So it's probably wrong.

-Andi
