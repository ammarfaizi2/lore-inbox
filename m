Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbVKUUVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbVKUUVD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 15:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035AbVKUUVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 15:21:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:31624 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750932AbVKUUVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 15:21:00 -0500
Date: Mon, 21 Nov 2005 12:20:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386, nmi: signed vs unsigned mixup
Message-Id: <20051121122051.5724a089.akpm@osdl.org>
In-Reply-To: <9a8748490511210240n97ab19ev8c27dc7b6f0e3d51@mail.gmail.com>
References: <200511200010.33658.jesper.juhl@gmail.com>
	<20051119162805.47796de9.akpm@osdl.org>
	<9a8748490511191630r3ad3e24w4e6d21b3f3b0c3a7@mail.gmail.com>
	<20051119170818.5e16afae.akpm@osdl.org>
	<9a8748490511191715x61057bc8i1431ca3a24cfb2e6@mail.gmail.com>
	<20051119173358.2bf1dbb5.akpm@osdl.org>
	<9a8748490511191745h6aebd102r91007bc2b84382ff@mail.gmail.com>
	<9a8748490511210240n97ab19ev8c27dc7b6f0e3d51@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <jesper.juhl@gmail.com> wrote:
>
> So, if we just cleaned up the top 10 offenders we'd get rid of 6281
>  out of the total 14491 warnings.

Yes, that's sane - it'll help make the warning output more manageable.  I
think the i386/bitops.h one is fixed in -mm.

