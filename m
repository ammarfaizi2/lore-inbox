Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbTIJKiG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 06:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbTIJKiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 06:38:06 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:52112 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261757AbTIJKiD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 06:38:03 -0400
Date: Wed, 10 Sep 2003 11:37:52 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Luca Veraldi <luca.veraldi@katamail.com>, alexander.riesen@synopsys.COM,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Efficient IPC mechanism on Linux
Message-ID: <20030910103752.GC21313@mail.jlokier.co.uk>
References: <00f201c376f8$231d5e00$beae7450@wssupremo> <20030909175821.GL16080@Synopsys.COM> <001d01c37703$8edc10e0$36af7450@wssupremo> <20030910064508.GA25795@Synopsys.COM> <015601c3777c$8c63b2e0$5aaf7450@wssupremo> <1063185795.5021.4.camel@laptop.fenrus.com> <20030910095255.GA21313@mail.jlokier.co.uk> <20030910120729.C14352@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910120729.C14352@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> > I have just done a measurement on a 366MHz PII Celeron
> 
> This test is sort of the worst case against my argument:
> 1) It's a cpu with low memory bandwidth
> 2) It's a 1 CPU system
> 3) It's a pII not pIV; the pII is way more efficient cycle wise
>    for pagetable operations

I thought that later generation CPUs were supposed to have lower
memory bandwidth relative to the CPU core, so CPU operations are
better than copying.  Hence all the fancy special memory instructions,
to work around that.

Not that it matters.  I think the 366 Celeron is typical of a lot of
computers being used today.  I still use it every day, after all.

-- Jaie

