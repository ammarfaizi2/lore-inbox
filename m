Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262779AbSKRPI1>; Mon, 18 Nov 2002 10:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262780AbSKRPI1>; Mon, 18 Nov 2002 10:08:27 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:47101 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S262779AbSKRPI1>; Mon, 18 Nov 2002 10:08:27 -0500
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3DD3FCB3.40506@us.ibm.com> 
References: <3DD3FCB3.40506@us.ibm.com> 
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] early printk for x86 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 18 Nov 2002 15:15:23 +0000
Message-ID: <14814.1037632523@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


haveblue@us.ibm.com said:
>  1.	 I copied the x86_64 early printk support for plain x86.  Is
> anyone  opposed to me sending this on to Linus?

Why is it necessary to reimplement serial console for each arch rather than
just registering the generic serial console as early as possible from
arch-specific code?

There's no _reason_ to wait for console_init(), for most consoles.

--
dwmw2


