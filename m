Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266720AbSKLTKk>; Tue, 12 Nov 2002 14:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266738AbSKLTKk>; Tue, 12 Nov 2002 14:10:40 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:65241 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S266720AbSKLTKk>;
	Tue, 12 Nov 2002 14:10:40 -0500
Date: Tue, 12 Nov 2002 19:17:22 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       "'mingo@redhat.com'" <mingo@redhat.com>,
       "'Mark Mielke'" <mark@mark.mielke.cc>, linux-kernel@vger.kernel.org
Subject: Re: Users locking memory using futexes
Message-ID: <20021112191722.GA14473@bjl1.asuk.net>
References: <A46BBDB345A7D5118EC90002A5072C7806CAC923@orsmsx116.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C7806CAC923@orsmsx116.jf.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perez-Gonzalez, Inaky wrote:
> Hum ... still I want to try Ingo's approach on the ptes; that is the part I
> was missing [knowing that struct page * is not invariant as the pte number
> ... even being as obvious as it is].

Btw, pte number of private mapping is not invariant over mremap(), but
otherwise I think it is fine.

- Jamie
