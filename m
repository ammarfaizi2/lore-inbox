Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316477AbSGYVJO>; Thu, 25 Jul 2002 17:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316491AbSGYVJO>; Thu, 25 Jul 2002 17:09:14 -0400
Received: from gate.in-addr.de ([212.8.193.158]:3339 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S316477AbSGYVJN>;
	Thu, 25 Jul 2002 17:09:13 -0400
Date: Thu, 25 Jul 2002 23:12:25 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Andrea Arcangeli <andrea@suse.de>, Cort Dougan <cort@fsmlabs.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cheap lookup of symbol names on oops()
Message-ID: <20020725211225.GG10033@marowsky-bree.de>
References: <20020725110033.G2276@host110.fsmlabs.com> <20020725181126.A17859@infradead.org> <20020725112142.I2276@host110.fsmlabs.com> <20020725190445.GO1180@dualathlon.random> <20020725142716.N2276@host110.fsmlabs.com> <20020725205910.GR1180@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020725205910.GR1180@dualathlon.random>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-07-25T22:59:10,
   Andrea Arcangeli <andrea@suse.de> said:

> One thing is if you have ksymall ala kdb and you can resolve to
> something where you don't need the system.map to guess what happened,
> but without the ksymall you need the system.map or vmlinux anyways.

I am still not convinced that this isn't the better approach overall; yes, the
full ksymall table takes a few kb in memory, which can be avoided if one has a
full vmlinux / System.map archive (as it would in theory be possible for a
distribution for all shipped kernels), but having the fully decoded Oops - or
at least, as far as possible - would certainly be more useful in the general
case, and for self-compiled kernels.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Immortality is an adequate definition of high availability for me.
	--- Gregory F. Pfister

