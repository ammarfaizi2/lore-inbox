Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280952AbRK3TAl>; Fri, 30 Nov 2001 14:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280960AbRK3TAb>; Fri, 30 Nov 2001 14:00:31 -0500
Received: from mail309.mail.bellsouth.net ([205.152.58.169]:15275 "EHLO
	imf09bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S280952AbRK3TAY>; Fri, 30 Nov 2001 14:00:24 -0500
Message-ID: <3C07D742.A62FF72E@mandrakesoft.com>
Date: Fri, 30 Nov 2001 14:00:18 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Paul G. Allen" <pgallen@randomlogic.com>
CC: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: Coding style - a non-issue
In-Reply-To: <OF8451D8AC.A8591425-ON4A256B12.00806245@au.ibm.com> <Pine.GSO.4.21.0111281901110.8609-100000@weyl.math.psu.edu> <20011128162317.B23210@work.bitmover.com> <9u7lb0$8t9$1@forge.intermeta.de> <20011130072634.E14710@work.bitmover.com> <1007138360.6656.27.camel@forge> <3C07B820.4108246F@mandrakesoft.com> <20011130185359.Q31176@blu> <3C07CDFB.7F1A9FFC@randomlogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul G. Allen" wrote:
> A variable/function name should ALWAYS be descriptive of the
> variable/function purpose. If it takes a long name, so be it. At least
> the next guy looking at it will know what it is for.

That's complete crap.  Human beings know and understand context, and can
use it effectively.  'idx' or 'i' or 'bh' may make perfect sense in
context.  There is absolutely no need for
JournalBHThatIsStoredAndSyncedWithSuperblock.

Kernel code like DAC960 proves that long variable names -decrease- code
readability.

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

