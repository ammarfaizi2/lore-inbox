Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWI0Lbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWI0Lbi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 07:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWI0Lbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 07:31:38 -0400
Received: from colin.muc.de ([193.149.48.1]:31763 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S932183AbWI0Lbi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 07:31:38 -0400
Date: 27 Sep 2006 13:31:36 +0200
Date: Wed, 27 Sep 2006 13:31:36 +0200
From: Andi Kleen <ak@muc.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: revised pda patches
Message-ID: <20060927113136.GA80066@muc.de>
References: <4518D273.2030103@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4518D273.2030103@goop.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2006 at 12:10:43AM -0700, Jeremy Fitzhardinge wrote:
> Hi Andi,
> 
> Here's an updated series of PDA patches based on your tree.  They're 
> intended to replace these:
> 
>    i386-pda-basics
>    i386-pda-init-pda
>    i386-pda-use-gs
>    i386-pda-user-abi
>    i386-pda-vm86
>    i386-pda-smp-processorid
>    i386-pda-current
> 
> with these:
> 
>    i386-pda-definitions.patch
>    i386-pda-init.patch
>    i386-pda-use-gs.patch
>    i386-pda-fix-abi.patch
>    i386-pda-fix-vm86.patch
>    i386-pda-smp_processor_id.patch
>    i386-pda-current.patch

I added them now, thanks.

At least one seemed to assume that asm-offsets.c already has entries
for all the registers, which wasn't the case. I fixed that up from
the patch context, but some double checking might be useful.

-Andi
