Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267439AbUBRStL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 13:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267821AbUBRStL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 13:49:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:44199 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267439AbUBRStH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 13:49:07 -0500
Date: Wed, 18 Feb 2004 10:50:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm1
Message-Id: <20040218105016.44ca830c.akpm@osdl.org>
In-Reply-To: <20040218135623.112C92C3B8@lists.samba.org>
References: <20040218012553.1228ae34.akpm@osdl.org>
	<20040218135623.112C92C3B8@lists.samba.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
>
> Do you want me to consolidate the patches in your tree?  At the moment
>  you're carrying:
> 
>  kthread-primitive.patch
>  kthread-affinity-fix.patch
>  kthread-affinity-fix-fix.patch
>  kthread-handle-non-booting-CPUs.patch
>  kthread-stop-using-signals.patch
> 
>  Which are logically a single "kthread-without-signals" patch.

Is OK, thanks - that is merely a matter of typing `joinpatch $(nextpatch);
drop-patch $(nextpatch)' four times.

I generally keep these things separated for quite a long time because it
aids in the binary-search-to-see-what-broke-it game.
