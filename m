Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282161AbRKWPe7>; Fri, 23 Nov 2001 10:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282162AbRKWPet>; Fri, 23 Nov 2001 10:34:49 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:47899 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S282161AbRKWPen>; Fri, 23 Nov 2001 10:34:43 -0500
Date: Fri, 23 Nov 2001 10:34:34 -0500
From: Arjan van de Ven <arjanv@redhat.com>
To: =?iso-8859-1?Q?G=E1bor_L=E9n=E1rt?= <lgb@lgb.hu>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Which gcc version?
Message-ID: <20011123103434.A24669@devserv.devel.redhat.com>
In-Reply-To: <20011123125137Z282133-17408+17815@vger.kernel.org> <5.1.0.14.2.20011123135801.00aad970@pop.cus.cam.ac.uk> <3BFE591B.D1F75CD5@starband.net> <3BFE67E8.CFA0D371@redhat.com> <20011123163019.A5418@vega.digitel2002.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011123163019.A5418@vega.digitel2002.hu>; from lgb@lgb.hu on Fri, Nov 23, 2001 at 04:30:19PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2001 at 04:30:19PM +0100, Gábor Lénárt wrote:
> True, but as it's known, gcc-2.96 is NOT an official gcc release by the gcc
> team. It was RedHat's fault to fetch a development CVS gcc snapshot and
> release it as gcc 2.96 in RedHat distributions, while object format used by
> 2.96 is not compatible with 2.95 nor 3.0.x at least according information
> can be found on site of gcc.

That is only the case for C++. And the same is true for egcs -> 2.95.x and
from 2.95.x -> 3.0.x and from 3.0.x -> 3.1

> It was very ROTFL RedHat to release kgcc to be
> able to compile kernel.

gcc 3.0 doesn't compile 2.2 kernels. "2.96" is like 3.0 in that respect. All
2.4 kernel RPMs from Red Hat are compiled with the "2.96" gcc.

> [Also, while developing MPlayer we had got problems with even
> newer 2.96's, so we do not recommend it in the dox, and ./configure won't
> able you to use 2.96 without a special configure switch ...]

I noticed yes. Most likely a case of broken inline asm..... 
gcc 3 will break just as much
