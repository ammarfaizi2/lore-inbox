Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbVK2OEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbVK2OEM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 09:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbVK2OEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 09:04:12 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:56772 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750883AbVK2OEL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 09:04:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kvHeBwnvyE3dT2hCf1jxiil93NH3qiX/zzrMieIAtbuVH623k/++BCiBRhumVdv4Ao/g7cmc/GH9I6JSB3zFLeMrZFfB6y06PenSKn2NyZYbzMDodC2x+H6Ylu+ey3JwLabtr44fFxYj2FGVikpLqzrtaYulZqeVqk8TECaPe/U=
Message-ID: <121a28810511290604m68c56398t@mail.gmail.com>
Date: Tue, 29 Nov 2005 15:04:10 +0100
From: Grzegorz Nosek <grzegorz.nosek@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] race condition in procfs
Cc: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org
In-Reply-To: <121a28810511290525m1bdf12e0n@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <121a28810511282317j47a90f6t@mail.gmail.com>
	 <20051129000916.6306da8b.akpm@osdl.org>
	 <121a28810511290038h37067fecx@mail.gmail.com>
	 <121a28810511290525m1bdf12e0n@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/11/29, Grzegorz Nosek <grzegorz.nosek@gmail.com>:
>
> Oh well, I got another oops in the very same place with the patch
> applied. So now I surrounded the check with
> read_[un]lock(&tasklist_lock) and added a check to do_task_stat (both
> now have a printk). If it builds, boots and doesn't crash, I'll post
> the patch.

Froze solid a minute after booting :( netconsole didn't log anything
either. Back to the drawing board.

Best regards,
 Grzegorz Nosek
