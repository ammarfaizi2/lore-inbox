Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbUJ0Lcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbUJ0Lcu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 07:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262383AbUJ0Lcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 07:32:50 -0400
Received: from zamok.crans.org ([138.231.136.6]:30645 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S262382AbUJ0Lct convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 07:32:49 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm1
References: <20041026213156.682f35ca.akpm@osdl.org>
From: Mathieu Segaud <matt@minas-morgul.org>
Date: Wed, 27 Oct 2004 13:32:47 +0200
In-Reply-To: <20041026213156.682f35ca.akpm@osdl.org> (Andrew Morton's message
	of "Tue, 26 Oct 2004 21:31:56 -0700")
Message-ID: <87breos8f4.fsf@barad-dur.crans.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> disait dernièrement que :

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm1/
>
>
> - Nothing really major here - just lots of minor things spread all over the
>   place.
>
> - I actually managed to get most of the "external BK trees" included.  A lot
>   of them have been pretty flakey lately (hint).
>
> - This kernel is probably pretty crappy - there is a _lot_ of stuff
>   happening and the quality of the patches which I am receiving seems to be
>   gradually dropping off.  

It fails to build if CONFIG_FS_REISER4=y and issues a depmod error if reiser4
is built modular, as delete_from_page_cache has been ripped out

Best regards,

Mathieu

-- 
printk(KERN_ERR "Danger Will Robinson: failed to re-trigger IRQ%d\n", irq);
        linux-2.6.6/arch/arm/common/sa1111.c

