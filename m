Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030711AbWI0TqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030711AbWI0TqW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 15:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030722AbWI0TqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 15:46:22 -0400
Received: from colin.muc.de ([193.149.48.1]:46608 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1030721AbWI0TqV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 15:46:21 -0400
Date: 27 Sep 2006 21:46:19 +0200
Date: Wed, 27 Sep 2006 21:46:19 +0200
From: Andi Kleen <ak@muc.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: revised pda patches
Message-ID: <20060927194619.GB80066@muc.de>
References: <4518D273.2030103@goop.org> <20060927113136.GA80066@muc.de> <451AAE0A.4010704@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <451AAE0A.4010704@goop.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2006 at 09:59:54AM -0700, Jeremy Fitzhardinge wrote:
> Andi Kleen wrote:
> >I added them now, thanks.
> >
> >At least one seemed to assume that asm-offsets.c already has entries
> >for all the registers, which wasn't the case. I fixed that up from
> >the patch context, but some double checking might be useful.
> >  
> 
> Eh?  They patch+compile cleanly against your patch queue of the other 
> day.  -use-gs adds PT_GS to asm-offsets, assuming that 
> "i386-pda-asm-offsets" has already been applied.  Did you accidentally 
> remove that from your queue too; it was just before the old 
> "i386-pda-basics"?

Yes I dropped all i386-pda-* patches earlier.
Also BTW the result didn't boot. Ok will try with that old patch too.

-Andi
