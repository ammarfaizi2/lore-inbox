Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbWICWQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbWICWQL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 18:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWICWPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 18:15:40 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:3426 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750940AbWICWOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 18:14:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=lJ/2Hf2Sktib6jCdX09u5+q0QZ6NIXkEToWE1D/meVqE+LNkLD9GqwrKiK0XoEko2FDSKJ9nInQjnAdgzTuiShB8/zCM378FO/rCb7l3VTvAreNVdYbZerw6+RtLbDwPTl7FrLEkwNFlJnrTP2VMM/2QdBoOto+gY2jvoEb8aM0=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 01/26] Dynamic kernel command-line - common
Date: Mon, 4 Sep 2006 01:12:57 +0300
User-Agent: KMail/1.9.4
Cc: Andi Kleen <ak@suse.de>, Matt Domsch <Matt_Domsch@dell.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johninsd@san.rr.com, davej@codemonkey.org.uk, Riley@williams.name,
       trini@kernel.crashing.org, davem@davemloft.net, ecd@brainaid.de,
       jj@sunsite.ms.mff.cuni.cz, anton@samba.org, wli@holomorphy.com,
       lethal@linux-sh.org, rc@rc0.org.uk, spyro@f2s.com, rth@twiddle.net,
       avr32@atmel.com, hskinnemoen@atmel.com, starvik@axis.com,
       ralf@linux-mips.org, grundler@parisc-linux.org, geert@linux-m68k.org,
       zippel@linux-m68k.org, paulus@samba.org, schwidefsky@de.ibm.com,
       heiko.carstens@de.ibm.com, uclinux-v850@lsi.nec.co.jp, chris@zankel.net
References: <200609040050.13410.alon.barlev@gmail.com> <200609040052.15870.alon.barlev@gmail.com> <20060903221002.GE2558@parisc-linux.org>
In-Reply-To: <20060903221002.GE2558@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609040112.58872.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 September 2006 01:10, Matthew Wilcox wrote:
> Your patch is wordwrapped.

Thanks!
My mistake!
I will send again.

> Also, what was the point of all this?  Was there some
> discussion that this would be useful?

Yes. We are trying to make kernel parameter size much larger 
than 256 bytes (at least for x86).

And some developers commented that small systems will be 
affected if static buffer enlarged.

Best Regards,
Alon Bar-Lev.

-- 
VGER BF report: H 2.02507e-07
