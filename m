Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289658AbSAKJwp>; Fri, 11 Jan 2002 04:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289588AbSAKJwa>; Fri, 11 Jan 2002 04:52:30 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:52937 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S289051AbSAKJwP>; Fri, 11 Jan 2002 04:52:15 -0500
Message-Id: <200201110952.g0B9q8Y03754@jupiter.cs.uni-dortmund.de>
To: Bernard Dautrevaux <Dautrevaux@microprocess.com>
cc: "'gcc@gcc.gnu.org'" <gcc@gcc.gnu.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] C undefined behavior fix 
In-Reply-To: Message from Bernard Dautrevaux <Dautrevaux@microprocess.com> 
   of "Tue, 08 Jan 2002 12:12:58 +0100." <17B78BDF120BD411B70100500422FC6309E409@IIS000> 
From: Horst von Brand <brand@tigger.cs.uni-dortmund.de>
Date: Fri, 11 Jan 2002 10:52:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernard Dautrevaux <Dautrevaux@microprocess.com> said:

[...]

> So at least for the first test, gcc-3.1 generates the same (anoying) code as
> 2.95.3. I'm quite sure this is legal, as I can't see in the standard if when
> writing:
> 
> 	volatile unsigned int x:8;
> 
> I define:
> 	1) a volatile 8-bit field to be interpreted as an unsigned int.
> 	2) an 8-bit field which is part of a volatile unsigned int.

If the whole is volatile (x must be inside a struct) make that volatile.
Sounds quite natural to me...
-- 
Horst von Brand			     http://counter.li.org # 22616
