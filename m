Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277756AbRJRPtH>; Thu, 18 Oct 2001 11:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277766AbRJRPs5>; Thu, 18 Oct 2001 11:48:57 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:64522 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S277756AbRJRPsq>; Thu, 18 Oct 2001 11:48:46 -0400
Date: Thu, 18 Oct 2001 11:49:21 -0400
From: Arjan van de Ven <arjanv@redhat.com>
To: Roy Murphy <murphy@panix.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MODULE_LICENSE and EXPORT_SYMBOL_GPL
Message-ID: <20011018114921.A30969@devserv.devel.redhat.com>
In-Reply-To: <3bcef893.4872.0@panix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3bcef893.4872.0@panix.com>; from murphy@panix.com on Thu, Oct 18, 2001 at 11:43:15AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2001 at 11:43:15AM -0500, Roy Murphy wrote:
> 'Twas brillig when Arjan van de Ven scrobe:
> >I think you're missing one thing: binary only modules are only allowed
> >because of an exception license grant Linus made for functions that are
> >marked EXPORT_SYMBOL(). EXPORT_SYMBOL_GPL() just says "not part of 
> >this exception grant"....
> 
> With all respect to Linus, I don't believe that module insertion is an 
> exclusive right granted to authors that is within Linus' legal power as holder
> of the Copyright to the kernel to grant or to restrict.  Does Microsoft have
> a legal right to disallow any third-party drivers from 
> registering themselves with the OS?  Does Linus?

I'm sorry. "module inserting" is LINKING. A kernel module does, in my
oppinion, NOT fall under the gpl stated "mere aggregation" boundary of the
GPL, it is compiled with kernel headers, contains kernel _code_ from these
headers etc etc, and is for all intents and purposes part of the GPL program
"kernel" once loaded. It uses normal function calls etc etc, symbols are
resolved using normal linking mechanisms etc etc.

