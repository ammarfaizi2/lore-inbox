Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161680AbWKHXWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161680AbWKHXWF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 18:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161712AbWKHXWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 18:22:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53177 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161680AbWKHXWC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 18:22:02 -0500
Date: Wed, 8 Nov 2006 15:18:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rdreier@cisco.com, ebiederm@xmission.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH] IB/ipath - program intconfig register using new HT irq
 hook
Message-Id: <20061108151821.5a55fecd.akpm@osdl.org>
In-Reply-To: <4552636E.3090809@pathscale.com>
References: <545156d49f883c43af70.1163024486@localhost.localdomain>
	<20061108144402.0b6a7b23.akpm@osdl.org>
	<4552636E.3090809@pathscale.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Nov 2006 15:08:30 -0800
"Bryan O'Sullivan" <bos@pathscale.com> wrote:

> Andrew Morton wrote:
> 
> > so...  Is this:
> > 
> > htirq-refactor-so-we-only-have-one-function-that-writes-to-the-chip.patch
> > htirq-allow-buggy-drivers-of-buggy-hardware-to-write-the-registers.patch
> 
> You should drop the above patch from Eric...
> 
> > htirq-allow-buggy-drivers-of-buggy-hardware-to-write-the-registers-update.patch
> 
> ...in favour of this one, which is my rework of Eric's patch.
> 
> > ib-ipath-program-intconfig-register-using-new-ht-irq-hook.patch

If you look, you'll see that the
htirq-allow-buggy-drivers-of-buggy-hardware-to-write-the-registers-update.patch
which I merged is the diff between Eric's patch and yours (ie: the diff
which you should have sent ;))

> > considered 2.6.19 material?
> 
> Yes, please.  I might be able to simplify the ib-ipath patch (by a 
> matter of a few lines), but it works fine as it stands.
> 

ho hum, OK.
