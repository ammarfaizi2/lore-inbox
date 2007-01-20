Return-Path: <linux-kernel-owner+w=401wt.eu-S965105AbXATDp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965105AbXATDp2 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 22:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965108AbXATDp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 22:45:28 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:52015 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965105AbXATDp2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 22:45:28 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dITgvOWcdsYPsYTPJsVePnp5m/5Nx4AnvjpEA5MGoKab2ee1nJ7tdvDGSq6wrpPVqoKqrrIzrMoISUPdYhjEEOqLSQs8Sbwx2uf2drly/wPtfefe7GiBHqtNUThT8WVjccVIMXqPctMv3ykDLzHN/B5hAU5f31Wg2f8Pqw5Bqiw=
Message-ID: <8355959a0701191945q692bd32dod32b27170790d51b@mail.gmail.com>
Date: Sat, 20 Jan 2007 09:15:26 +0530
From: "Sunil Naidu" <akula2.shark@gmail.com>
To: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Subject: Re: Choosing a HyperThreading/SMP/MultiCore kernel ?
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
In-Reply-To: <20070113175443.GX17267@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <8355959a0701120525m5d1a7904i56b8a8f7316883d6@mail.gmail.com>
	 <20070112150349.GI17269@csclub.uwaterloo.ca>
	 <200701130338.l0D3chOs026407@turing-police.cc.vt.edu>
	 <20070113175443.GX17267@csclub.uwaterloo.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/07, Lennart Sorensen <lsorense@csclub.uwaterloo.ca> wrote:
> On Fri, Jan 12, 2007 at 10:38:43PM -0500, Valdis.Kletnieks@vt.edu wrote:
> > amd64 will only work on a core2duo if it's a T7200 or higher - the
> > lower numbers are 32-bit-only chipsets.  I admit not knowing what
> > exact variant the Mac has.

2.33GHz Intel Core 2 Duo - 4MB shared L2 cache with ATI Mobility
Radeon X1600 with 256MB of GDDR3 SDRAM


> The Core Duo had 32bit only (being a Pentium M), but the Core 2 Duo
> should always be 64bit capable (at least that is what this list says:
> http://en.wikipedia.org/wiki/List_of_Intel_Core_2_microprocessors#Core_2_Duo_2
> )

Thank's for that. Yep, it is 64-bit capable with EM64T & with Intel
Vitualization.

I do not know yet whether 2.6.19 or 2.6.20-rc5 supports  and iSight
Video Camera, ATI DDR3 support, Apple Mobile Remote Control, and some
sensors like Motion, Light, Thermal, etc. (any suggestion where to
look for linux support?).

>
> > CONFIG_MCORE2=y
>

Got it, thanks

>
> --
> Len Sorensen
>

Should I wait for 2.6.20 release so that code would run with no oops
or less problematic?

Thanks,

~Akula2
