Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbWBGCC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbWBGCC0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 21:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWBGCC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 21:02:26 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:40869 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932439AbWBGCCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 21:02:24 -0500
Date: Tue, 7 Feb 2006 11:02:16 +0900
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>, dev-etrax@axis.com,
       Yoshinori Sato <ysato@users.sourceforge.jp>, linux-ia64@vger.kernel.org,
       Hirokazu Takata <takata@linux-m32r.org>,
       Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org,
       parisc-linux@parisc-linux.org, linuxsh-dev@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
       Chris Zankel <chris@zankel.net>
Subject: Re: [patch 11/44] generic find_{next,first}{,_zero}_bit()
Message-ID: <20060207020216.GA9323@miraclelinux.com>
References: <20060201090324.373982000@localhost.localdomain> <20060201090224.536581000@localhost.localdomain> <12367.1139221560@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12367.1139221560@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2006 at 10:26:00AM +0000, David Howells wrote:
> Akinobu Mita <mita@miraclelinux.com> wrote:
> 
> > This patch introduces the C-language equivalents of the functions below:
> > 
> > unsigned logn find_next_bit(const unsigned long *addr, unsigned long size,
> >                             unsigned long offset);
> > unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
> >                                  unsigned long offset);
> > unsigned long find_first_zero_bit(const unsigned long *addr,
> >                                   unsigned long size);
> > unsigned long find_first_bit(const unsigned long *addr, unsigned long size);
> 
> These big functions should perhaps be out of line.

Yes. I'll make them and below out of line.

- hweight*()
- ext2_find_*_zero_bit()
- minix_find_first_zero_bit()
