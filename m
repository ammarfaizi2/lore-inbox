Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265164AbUASPLJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 10:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265178AbUASPLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 10:11:09 -0500
Received: from colin2.muc.de ([193.149.48.15]:13576 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S265164AbUASPJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 10:09:52 -0500
Date: 19 Jan 2004 16:10:32 +0100
Date: Mon, 19 Jan 2004 16:10:31 +0100
From: Andi Kleen <ak@colin2.muc.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andi Kleen <ak@muc.de>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Modernize i386 string.h
Message-ID: <20040119151031.GA64150@colin2.muc.de>
References: <20040118200919.GA26573@averell> <400BE923.1020505@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400BE923.1020505@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ISTR this patch being shot down in the past...

I don't remember that.

> 
> It seems suboptimal for people with ancient compilers, or for people on 
> embedded 486's, doesn't it?

It is unlikely to make much difference for them. Kernel str* handling
is not very time critical (except memset/memcpy, but they are handled
efficiently on all compilers) The patch is mainly to make the code
more maintainable.

-Andi

