Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270414AbUJUG0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270414AbUJUG0S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 02:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270418AbUJTT2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 15:28:23 -0400
Received: from cantor.suse.de ([195.135.220.2]:38080 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S270241AbUJTTTy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:19:54 -0400
Date: Wed, 20 Oct 2004 21:16:50 +0200
From: Andi Kleen <ak@suse.de>
To: Olaf Hering <olh@suse.de>
Cc: Andreas Kleen <ak@suse.de>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix cross compile on x86_64
Message-ID: <20041020191650.GA1493@wotan.suse.de>
References: <20041020183504.GA11821@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020183504.GA11821@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 08:35:04PM +0200, Olaf Hering wrote:
> 
> make all fails while building a helper app:
> 
> arch/x86_64/boot/tools/build.c:36:22: asm/boot.h: No such file or directory
> 
> Possible that make O=$foo did never work on x86_64.

It works just fine with make bzImage and make. I'm not sure what
"make all" is good for though. 

> 
> This patch fixes it for me.

Thanks.

-Andi
