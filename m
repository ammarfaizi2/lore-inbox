Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265869AbTIJWHD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 18:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265872AbTIJWHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 18:07:03 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:17553 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S265869AbTIJWGq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 18:06:46 -0400
Date: Wed, 10 Sep 2003 23:06:24 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Luca Veraldi <luca.veraldi@katamail.com>, alexander.riesen@synopsys.COM,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Efficient IPC mechanism on Linux
Message-ID: <20030910220624.GE24258@mail.jlokier.co.uk>
References: <00f201c376f8$231d5e00$beae7450@wssupremo> <20030909175821.GL16080@Synopsys.COM> <001d01c37703$8edc10e0$36af7450@wssupremo> <20030910064508.GA25795@Synopsys.COM> <015601c3777c$8c63b2e0$5aaf7450@wssupremo> <1063185795.5021.4.camel@laptop.fenrus.com> <20030910095255.GA21313@mail.jlokier.co.uk> <20030910192426.GE2589@elf.ucw.cz> <20030910194042.GA24424@mail.jlokier.co.uk> <20030910213514.GC257@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910213514.GC257@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> But you should also time memory remapping stuff on same cpu, no?

Yes, but can I be bothered ;)
Like I said, it's a crude upper bound.

We know the remapping time will be about the same in both tests,
because all it does is the same vma operations and the same TLB
invalidations.

-- Jamie
