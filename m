Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261977AbSJDWmY>; Fri, 4 Oct 2002 18:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262063AbSJDWmY>; Fri, 4 Oct 2002 18:42:24 -0400
Received: from ip-208-181-150-114.adsl.radiant.net ([208.181.150.114]:32388
	"EHLO kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S261977AbSJDWmX>; Fri, 4 Oct 2002 18:42:23 -0400
Date: Fri, 4 Oct 2002 23:47:06 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@zip.com.au>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 'sticky pages' support in the VM, futex-2.5.38-C5
Message-ID: <20021004234706.A6683@kushida.apsleyroad.org>
References: <Pine.LNX.4.44.0209261311070.11487-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0209261311070.11487-100000@localhost.localdomain>; from mingo@elte.hu on Thu, Sep 26, 2002 at 01:30:55PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> futexes were not really designed with COW in mind - they were designed
> to be used in non-COW shared memory. This is a very bad limitation

I thought that futex-based locks were only reliable with PROT_SEM
memory, for architectures that define PROT_SEM (e.g. PPC) -- because of
the need for locking primitives to work in a cache coherent manner.

Is this not so?

-- Jamie
