Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312997AbSC0MTb>; Wed, 27 Mar 2002 07:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313000AbSC0MTW>; Wed, 27 Mar 2002 07:19:22 -0500
Received: from cpe.atm0-0-0-1221082.0x3ef261a2.bynxx2.customer.tele.dk ([62.242.97.162]:10624
	"EHLO fugmann.dhs.org") by vger.kernel.org with ESMTP
	id <S312997AbSC0MTF>; Wed, 27 Mar 2002 07:19:05 -0500
Message-ID: <3CA1B8B2.8020907@fugmann.dhs.org>
Date: Wed, 27 Mar 2002 13:18:58 +0100
From: Anders Peter Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020326 Debian/2:0.9.9-3pre4v3
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.4.19pre4-ac1
In-Reply-To: <E16pvYV-0003cD-00@the-village.bc.nu>	<3CA0EAAA.8000400@fugmann.dhs.org>	<15520.61687.962869.841296@notabene.cse.unsw.edu.au>	<3CA1081D.7040101@fugmann.dhs.org> <15521.10564.475227.372522@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> 
> I bet you're using reisferfs ???
Yes, amongst others.


> 
> It occasionaly uses filehandles longer than 32 bytes (the max for
> NFSv2) and my calculations forgot that nfsv3 allows for 64 bytes.
> So "9" (8 longs and a count) should be "17" (16 longs and a count).
Perfect - The patch is applied and kernel booted. Preliminary tests shows no problems.

> 
> Thanks again,
Same to you.

Regards
Anders Fugmann

