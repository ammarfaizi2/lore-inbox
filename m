Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423943AbWKHXIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423943AbWKHXIV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 18:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423871AbWKHXIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 18:08:21 -0500
Received: from mx.pathscale.com ([64.160.42.68]:41434 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1423943AbWKHXIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 18:08:20 -0500
Message-ID: <4552636E.3090809@pathscale.com>
Date: Wed, 08 Nov 2006 15:08:30 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: rdreier@cisco.com, ebiederm@xmission.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH] IB/ipath - program intconfig register using new HT irq
 hook
References: <545156d49f883c43af70.1163024486@localhost.localdomain> <20061108144402.0b6a7b23.akpm@osdl.org>
In-Reply-To: <20061108144402.0b6a7b23.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> so...  Is this:
> 
> htirq-refactor-so-we-only-have-one-function-that-writes-to-the-chip.patch
> htirq-allow-buggy-drivers-of-buggy-hardware-to-write-the-registers.patch

You should drop the above patch from Eric...

> htirq-allow-buggy-drivers-of-buggy-hardware-to-write-the-registers-update.patch

...in favour of this one, which is my rework of Eric's patch.

> ib-ipath-program-intconfig-register-using-new-ht-irq-hook.patch
> 
> considered 2.6.19 material?

Yes, please.  I might be able to simplify the ib-ipath patch (by a 
matter of a few lines), but it works fine as it stands.

	<b

