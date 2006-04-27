Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751758AbWD0XHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758AbWD0XHI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 19:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbWD0XHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 19:07:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6630 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751758AbWD0XHH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 19:07:07 -0400
Date: Thu, 27 Apr 2006 16:06:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: James.Bottomley@HansenPartnership.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let X86_VOYAGER depend on SMP
Message-Id: <20060427160604.66b2a297.akpm@osdl.org>
In-Reply-To: <20060427203350.GR3570@stusta.de>
References: <20060427203350.GR3570@stusta.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> I noted that X86_VOYAGER=y and SMP=n doesn't compile.
> 
> It might be possible to fix this, but as far as I understand it, all 
> Voyager machines are SMP, implying that such a configuration doesn't 
> make much sense.

I was kinda waiting for James to express an opinion.  In theory it'd be
better to make uniproc-on-Voyager build, boot and run like the wind.

In practice, this patch looks practical ;)
