Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275475AbTHJIgI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 04:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275476AbTHJIgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 04:36:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:55468 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S275475AbTHJIgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 04:36:06 -0400
Date: Sun, 10 Aug 2003 01:30:41 -0700
From: "David S. Miller" <davem@redhat.com>
To: "YOSHIFUJI Hideaki / _$B5HF#1QL@" <yoshfuji@linux-ipv6.org>
Cc: jmorris@intercode.com.au, yoshfuji@linux-ipv6.org,
       linux-kernel@vger.kernel.org
Subject: Re: virt_to_offset() (Re: [RFC][PATCH] Make cryptoapi
 non-optional?)
Message-Id: <20030810013041.679ddc4c.davem@redhat.com>
In-Reply-To: <20030810.173215.102258218.yoshfuji@linux-ipv6.org>
References: <20030809194627.GV31810@waste.org>
	<20030809131715.17a5be2e.davem@redhat.com>
	<20030810081529.GX31810@waste.org>
	<20030810.173215.102258218.yoshfuji@linux-ipv6.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Aug 2003 17:32:15 +0900 (JST)
YOSHIFUJI Hideaki / _$B5HF#1QL@ <yoshfuji@linux-ipv6.org> wrote:

> BTW, we spread ((long) ptr & ~PAGE_MASK); it seems ugly.
> Why don't we have vert_to_offset(ptr) or something like this?
> #define virt_to_offset(ptr) ((unsigned long) (ptr) & ~PAGE_MASK)
> Is this bad idea?

With some name like "virt_to_pageoff()" it sounds like a great
idea.
