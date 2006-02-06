Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbWBFK1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbWBFK1J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 05:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbWBFK1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 05:27:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:1975 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751037AbWBFK1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 05:27:06 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060201090324.373982000@localhost.localdomain> 
References: <20060201090324.373982000@localhost.localdomain>  <20060201090224.536581000@localhost.localdomain> 
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>, dev-etrax@axis.com,
       David Howells <dhowells@redhat.com>,
       Yoshinori Sato <ysato@users.sourceforge.jp>, linux-ia64@vger.kernel.org,
       Hirokazu Takata <takata@linux-m32r.org>,
       Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org,
       parisc-linux@parisc-linux.org, linuxsh-dev@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
       Chris Zankel <chris@zankel.net>
Subject: Re: [patch 11/44] generic find_{next,first}{,_zero}_bit() 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Mon, 06 Feb 2006 10:26:00 +0000
Message-ID: <12367.1139221560@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Akinobu Mita <mita@miraclelinux.com> wrote:

> This patch introduces the C-language equivalents of the functions below:
> 
> unsigned logn find_next_bit(const unsigned long *addr, unsigned long size,
>                             unsigned long offset);
> unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
>                                  unsigned long offset);
> unsigned long find_first_zero_bit(const unsigned long *addr,
>                                   unsigned long size);
> unsigned long find_first_bit(const unsigned long *addr, unsigned long size);

These big functions should perhaps be out of line.

David
