Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317753AbSGRB2K>; Wed, 17 Jul 2002 21:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317763AbSGRB2K>; Wed, 17 Jul 2002 21:28:10 -0400
Received: from holomorphy.com ([66.224.33.161]:54408 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317753AbSGRB2K>;
	Wed, 17 Jul 2002 21:28:10 -0400
Date: Wed, 17 Jul 2002 18:31:03 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Jones <davej@suse.de>, Steven Cole <elenstev@mesatop.com>,
       linux-kernel@vger.kernel.org, Steven Cole <scole@lanl.gov>
Subject: Re: 2.5.25-dj2, kernel BUG at dcache.c:361
Message-ID: <20020718013103.GM1096@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Jones <davej@suse.de>, Steven Cole <elenstev@mesatop.com>,
	linux-kernel@vger.kernel.org, Steven Cole <scole@lanl.gov>
References: <1026936410.11636.107.camel@spc9.esa.lanl.gov> <20020717221640.D32389@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020717221640.D32389@suse.de>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2002 at 02:06:50PM -0600, Steven Cole wrote:
>> While running 2.5.25-dj2 and dbench with increasing numbers of clients,
>> my test machine locked up with the following message:
>> 
>> kernel BUG at dcache.c:361!

On Wed, Jul 17, 2002 at 10:16:40PM +0200, Dave Jones wrote:
> There are some -dj specific hacks to dcache.c to convert to use
> list_t types. Which from memory, I think William Lee Irwin did.
> (wli, can you double check those just in case there's either an
>  obvious thinko, or a mismerge if you get time ?)
> Failing that, this could be something that also affects mainline
> I think.

This is getting real ugly real fast. It looks like there's a lot more
to debug than the dcache. I'll stick around for a bit and send a few
other patches your way as well.


Cheers,
Bill
