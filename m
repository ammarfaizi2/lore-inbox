Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbUKAHgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbUKAHgm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 02:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbUKAHgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 02:36:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33926 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261478AbUKAHgk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 02:36:40 -0500
Date: Mon, 1 Nov 2004 02:36:28 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Marc Bevand <bevand_m@epita.fr>
cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [rc4-amd64] RC4 optimized for AMD64
In-Reply-To: <cm4moc$c7t$1@sea.gmane.org>
Message-ID: <Xine.LNX.4.44.0411010232470.2694-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Nov 2004, Marc Bevand wrote:

> I have just published a small paper about optimizing RC4 for
> AMD64 (x86-64). A working implementation is also provided:
> 
>   http://epita.fr/~bevand_m/papers/rc4-amd64.html
> 
> Kernel people may be interested given the fact that Linux
> already implements RC4.

Only problem is that the setkey code is released under a GPL incompatible
license.  Although it's probably not difficult to make the kernel's
existing C setkey code to work with the new asm code.


- James
-- 
James Morris
<jmorris@redhat.com>



