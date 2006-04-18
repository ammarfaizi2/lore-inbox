Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbWDSAlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWDSAlb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 20:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWDSAlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 20:41:31 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:29356 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1750824AbWDSAla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 20:41:30 -0400
Date: Tue, 18 Apr 2006 16:41:25 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Jon Masters <jonathan@jonmasters.org>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MODULE_FIRMWARE for binary firmware(s)
In-Reply-To: <35fb2e590604181715o5c381407ya80bdc3beedc5b68@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0604181637090.22439@qynat.qvtvafvgr.pbz>
References: <20060418234156.GA28346@apogee.jonmasters.org> 
 <Pine.LNX.4.62.0604181550380.22439@qynat.qvtvafvgr.pbz>
 <35fb2e590604181715o5c381407ya80bdc3beedc5b68@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2006, Jon Masters wrote:

>> Your approach is just fine if the things that will need firmware are
>> compiled as modules
>
> Hmmm. Yeah. I'm not sure what the general feeling is on this - I'm
> tempted to say that we expect modules to be used and that if they're
> not then the vendor/user has to do the hoop jumping for themselves.
> This code won't stop you from making a monolithic kernel and
> satisfying any module requirements for yourself :-)

Two things with this.

1. there is no way to satisfy the firmware requirements currently

2. I thought I heard Linus state recently that makeing something only work 
as a module was unacceptable, officially stateing that modules are 
required and monolithic kernels aren't allowed anymore doesn't sound 
reasonable.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

